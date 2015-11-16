<?php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext,
    OrangeDigital\BusinessSelectorExtension\Context\BusinessSelectorContext;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
// class FeatureContext extends BehatContext 
class FeatureContext extends Drupal\DrupalExtension\Context\DrupalContext
{
    private $pageInfo;
    /**
     * Initializes context.
     * Every scenario gets its own context object.
     *
     * @param array $parameters context parameters (set them in behat.yml)
     */

    public function __construct(array $parameters)
    {
      //$this->useContext('mink', new MinkContext($parameters));
      $this->useContext('BusinessSelectors', new BusinessSelectorContext($parameters));
    }

  /**
   * wait for jQuery to be available on page
   **/
  private function waitForjQuery(){
    $this->getSession()->wait(5000, 'typeof window.jQuery == "function"');
  }

  
  /**
   * @Then /^the lift variable "([^"]*)" should be set to "([^"]*)"$/
   */
  public function theLiftVariableShouldBeSetTo($arg1, $arg2)
  {
    $value;
    if($this->pageInfo && array_key_exists($arg1, $this->pageInfo)){
      $value = $this->pageInfo[$arg1];
    }
    
    if(!isset($value)){
      //print_r($this->pageInfo);
      throw new \Exception(sprintf('The lift variable "%s" was not defined', $arg1));
    }

    // Compare the result to the expected value
    if($value != $arg2){
      //print_r($this->pageInfo);
      throw new \Exception(sprintf('The lift variable "%s" was "%s", instead of "%s"', $arg1, $value, $arg2));
    }
  }

  /**
   * @Given /^the lift variable "([^"]*)" should not be set$/
   */
  public function theLiftVariableShouldNotBeSet($arg1)
  {
    // If the key exists, then the variable was included. Throw exception.
    if($this->pageInfo && array_key_exists($arg1, $this->pageInfo)){
      throw new \Exception(sprintf('The lift variable "%s" was defined, but should not have been', $arg1));
    }
  }

    /**
     * @Given I am tracking lift events
     */
    public function iAmTrackingLiftEvents()
    {
      $this->waitForjQuery();
      
       // Inject some JS to be able to detect when tracking images are created
      $script = <<<JS
        var OriginalImage  = window.Image;
        window.TrackedEvents = {};
        window.Image = function(width, height){
          var image = new OriginalImage(width, height);
          image.addEventListener('load', function(){
            var liftEvent = getParameterByName(this.src, "tcvc");
            window.TrackedEvents[liftEvent] = {src:this.src, times:1};
          });
          return image;
        }

        function getParameterByName(str, name) {
          name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
          var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
          results = regex.exec(str);
          return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        // open all links in new window to be able to track events 
        (function($){
          //$('a').attr("target", "_blank");
          $('a').click(function(e){e.preventDefault();});
        })(jQuery);

        console.log("Lift Event Tracking is on");
        return true;
JS;
      // Evaluate the JS. This returns the image src.
      $result = $this->getSession()->getDriver()->getWebDriverSession()->execute(array('script' => $script, 'args' => array()));

      if(!$result){
        throw new \Exception(sprintf('Could not track lift events'));
      }
    }
    /**
     * @Then /^I see "([^"]*)" event was tracked$/
     */
    public function iSeeEventWasTracked($arg1)
    {
      // Wait for the event tracking to happen
      sleep(3);

       // Grab the Tracked events
      $script = <<<JS
        return JSON.stringify(window.TrackedEvents);
JS;
      // Evaluate the JS. This returns the image src.
      $result = $this->getSession()->getDriver()->getWebDriverSession()->execute(array('script' => $script, 'args' => array()));
      $TrackedEvents = json_decode($result,true);

      if(!array_key_exists($arg1, $TrackedEvents)){
        throw new \Exception(sprintf('"%s" event does not seem to be tracked', $arg1));
      }
      
    }

  /**
   * @Given I get the lift variables
   */
  public function iGetTheLiftVariables()
  {
    $this->waitForjQuery();

    $script = <<<JS
      // Save the UDFs for retrieval later
      window.pageInfo = {};

      (function($){
        var udfValues = {};

        // Build the mappings
        var udfMappings = {};
        $.each(Drupal.settings.acquia_lift_profiles.mappings, function(k, v){
          $.extend(udfMappings, v)
        });

        var context_separator = Drupal.settings.acquia_lift_profiles.mappingContextSeparator;

        // Find the value for each UDF based on which pluginName it is in. 
        for(var udf in udfMappings){
          if(udfMappings.hasOwnProperty(udf)) {
            var context = udfMappings[udf].split(context_separator);
            var pluginName = context[0];
            var context_name = context[1];

            switch(pluginName){
              case 'querystring_context' :
                if(Drupal.settings.personalize_url_context.querystring_params){
                  udfValues[udf] = Drupal.settings.personalize_url_context.querystring_params[context_name];
                }
                break;
              case 'pfizer_lift' :
                if(Drupal.settings.pfizer_lift.contexts){
                  udfValues[udf] = Drupal.settings.pfizer_lift.contexts[context_name];
                }
                break;
              case 'entity_context' :
                if(Drupal.settings.entity_context){
                  udfValues[udf] = Drupal.settings.entity_context[context_name];
                }
                break;
            }
          }
        }

        // Combine the UDFs with the rest of the page info
        var pageInfo = $.extend({
            'content_title': 'Untitled',
            'content_type': 'page',
            'page_type': 'content page',
            'content_section': '',
            'content_keywords': '',
            'post_id': '',
            'published_date': '',
            'thumbnail_url': '',
            'persona': '',
            'engagement_score':'1',
            'author':'',
            'evalSegments': true
          }, Drupal.settings.acquia_lift_profiles.pageContext, udfValues);

        // Save the page info
        window.pageInfo = pageInfo;


      })(jQuery);
      //console.log(window.pageInfo);
      return JSON.stringify(window.pageInfo);
JS;
    $result = $this->getSession()->getDriver()->getWebDriverSession()->execute(array('script' => $script, 'args' => array()));
    $this->pageInfo = json_decode($result, true);
  }


   /**
    * @Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/
    */
    public function iAmLoggedInAsWithPassword($username, $password)
    {
      $this->waitForjQuery();

      $session = $this->getSession();
      // Go to login page
      $this->visit("/login?destination=");

      // Click sign in
      $session->getPage()->find('css', 'a.login')->click();

      //enter username and password
      $session->wait(5000,
        '(function($){return $("#capture_signIn_traditionalSignIn_emailAddress").length > 0; })(jQuery);'
      );
      $session->getPage()->find('css', '#capture_signIn_traditionalSignIn_emailAddress')->setValue($username);
      $session->getPage()->find('css', '#capture_signIn_traditionalSignIn_password')->setValue($password);

      //click sign in button
      $session->getPage()->find('css', '#capture_signIn_traditionalSignIn_signInButton')->click();

      //wait for logout link to be present
      $session->wait(5000,
        '(function($){return $("a.capture_end_session").length > 0; })(jQuery);'
      );
    }

    /**
     * @Then /^the lift variable "([^"]*)" should match the build number$/
     */
    public function theLiftVariableShouldMatchTheBuildNumber($arg1)
    {
      // Get the build number from the page
      $build_number = $this->getSession()->getPage()->find('css', '#block-pfizer-hcp-hcp-build-number .content')->getText();
      $this->theLiftVariableShouldBeSetTo($arg1, $build_number);

    }

  /**
   * @Then /^I see "([^"]*)" event was tracked with:$/
   */
  public function iSeeEventWasTrackedWith($arg1, TableNode $table)
  {
    // Wait for the event tracking to happen
    sleep(3);

     // Grab the Tracked events
    $script = <<<JS
      return JSON.stringify(window.TrackedEvents);
JS;
    // Evaluate the JS. This returns the image src.
    $result = $this->getSession()->getDriver()->getWebDriverSession()->execute(array('script' => $script, 'args' => array()));
    $TrackedEvents = json_decode($result,true);

    if(!array_key_exists($arg1, $TrackedEvents)){
      throw new \Exception(sprintf('"%s" event does not seem to be tracked', $arg1));
    }

    // Grab the query parameters and put them into an array $eventParams
    $eventSrc = parse_url($TrackedEvents[$arg1]['src']);
    $eventQuery = $eventSrc['query'];
    $eventParams = null;
    parse_str($eventQuery, $eventParams);

    $hash = $table->getHash();

    // Make sure that each row of the table: The parameter exists in the eventParams; and the value of the eventParams[param] = table value
    foreach($hash as $row){
      $tableParamKey = $row['key'];
      if(!array_key_exists($tableParamKey, $eventParams)){
        throw new \Exception(sprintf('"%s" was not included in the tracking code', $tableParamKey));
      }

      $tableParamValue = $row['value'];
      $eventParamValue = $eventParams[$tableParamKey];
      if($tableParamValue != $eventParamValue){
        throw new \Exception(sprintf('The tracking variable "%s" was "%s", instead of "%s"', $tableParamKey, $eventParamValue, $tableParamValue));

      }
    }
  }


  /**
   * @Then /^the lift variables should be set as:$/
   */
  public function theLiftVariablesShouldBeSetAs(TableNode $table) {
    // Grab the lift variables from the page and store them in pageInfo
    $this->iGetTheLiftVariables();

    $hash = $table->getHash();

    // Cycle through the table hash
    foreach($hash as $row){
      $key = $row['key'];
      $value = $row['value'];

      if(!array_key_exists($key, $this->pageInfo)){
        throw new \Exception(sprintf('"%s" was not set in the UDF variables',$key));
      }

      if($value != $this->pageInfo[$key]){
        throw new \Exception(sprintf('"%s" was set to "%s" instead of "%s"',$key, $this->pageInfo[$key], $value));
      }

    }
  }

  /**
   * @When /^I scroll to the bottom of the page$/
   */
  public function iScrollToTheBottomOfThePage() {
    $this->waitForjQuery();

    // JS to scroll to the bottom of the page
    $script = <<<JS
    (function($){
      $("html, body").animate({ scrollTop: $(document).height() }, 3000);
    })(jQuery);
JS;
    // execute the script
    $session = $this->getSession();
    $session->wait(5000, $script);
  }

  /**
   * @Then /^I print the lift variables$/
   */
  public function iPrintTheLiftVariables() {
    // Grab the lift variables from the page and store them in pageInfo
    $this->iGetTheLiftVariables();

    print_r($this->pageInfo);
  }

  /**
   * @Then /^I print the "([^"]*)" event variables$/
   */
  public function iPrintTheEventVariables($arg1) {
     // Grab the Tracked events
    $script = <<<JS
      return JSON.stringify(window.TrackedEvents);
JS;
    // Evaluate the JS. This returns the image src.
    $result = $this->getSession()->getDriver()->getWebDriverSession()->execute(array('script' => $script, 'args' => array()));
    $TrackedEvents = json_decode($result,true);

    if(!array_key_exists($arg1, $TrackedEvents)){
      throw new \Exception(sprintf('"%s" event does not seem to be tracked', $arg1));
    }

    // Grab the query parameters and put them into an array $eventParams
    $eventSrc = parse_url($TrackedEvents[$arg1]['src']);
    $eventQuery = $eventSrc['query'];
    $eventParams = null;
    parse_str($eventQuery, $eventParams);

    //print the variables
    print_r($eventParams);
  }

  /**
   * @Then /^I should see the css selector "([^"]*)"$/
   * @Then /^I should see the CSS selector "([^"]*)"$/
   */
  public function iShouldSeeTheCssSelector($css_selector) {
    $element = $this->getSession()->getPage()->find("css", $css_selector);
    if (empty($element)) {
      throw new \Exception(sprintf("The page '%s' does not contain the css selector '%s'", $this->getSession()->getCurrentUrl(), $css_selector));
    }
  }

  /**
   * @Then /^I should not see the css selector "([^"]*)"$/
   * @Then /^I should not see the CSS selector "([^"]*)"$/
   */
  public function iShouldNotSeeAElementWithCssSelector($css_selector) {
    $element = $this->getSession()->getPage()->find("css", $css_selector);
    if (empty($element)) {
      throw new \Exception(sprintf("The page '%s' contains the css selector '%s'", $this->getSession()->getCurrentUrl(), $css_selector));
    }
  }

  /**
   *
   * @When /^(?:|I )click the element with CSS selector "([^"]*)"$/
   * @When /^(?:|I )click the element with css selector "([^"]*)"$/
   */
  public function iClickTheElementWithCssSelector($css_selector) {
    $element = $this->getSession()->getPage()->find("css", $css_selector);
    if (empty($element)) {
      throw new \Exception(sprintf("The page '%s' does not contain the css selector '%s'", $this->getSession()->getCurrentUrl(), $css_selector));
    }
    $element->click();
  }
}
