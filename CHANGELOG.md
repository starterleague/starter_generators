## Version 0.9.3 (Oct 30, 2013)
* Change find_by_id to find_by(:id => params[:id])
* Change named routes to use old-style hash syntax

## Version 0.9.2 (Oct 22, 2013)
* Added skip_controller and skip_model options (default: false)

## Version 0.9.1 (Sept 4, 2013)
* Fixed #17, Typo: In index template, closing tbody tag is </body> instead of </tbody>
* Fixed #15, add .btn-primary or .btn-warning instead of just .btn
* Slightly improved form layouts
* Fixed #14 to use icons in index template when bootstrapped


## Version 0.9.0 (August 22, 2013)
* New --dry option to get scaffold-like refactoring (but without mass assignment)
*
## Version 0.8.0 (August 20, 2013)
* Bootstrap 3.0
* Horizontal form CSS applied when using --styled
* styler generator removes require_tree directive from application.css

## Version 0.7.3 (July 26, 2013)
* Remove footer from layout to avoid bootstrap grid weirdness

## Version 0.7.2 (July 26, 2013)
* Enhanced flash messaging

## Version 0.7.1 (July 25, 2013)
* Fix named routes

## Version 0.7.0  (July 25, 2013) ##
* Change BOOTSWATCH_NAME to THEME_NAME
* Use CDN for FontAwesome and Bootswatch themes.
* Use hardcoded bootstrap 2.3.2 default css and js.
* Rewrite USAGE info

## Version 0.6.0  (July 20, 2013) ##
* Rails 4 compatibility: use PATCH instead of PUT

## Version 0.3.1  (March 30, 2013) ##

* Fix edit templates to use @ivar in the form_tag call.

## Version 0.3 ##

* Add --named-routes option to starter:resource
* Add --styled option to starter:resource

## Version 0.2 (March 24, 2013) ##

* Add starter:style generator to make it easy to apply a bootswatch.  Not complete but mostly there.

## Version 0.1 (March 24, 2013) ##

* Properly close the erb tag for the link to the show action in the index template.  Also add a leading slash in the url.
* Added a destroy a link to the index template.

## Version 0.0.1 (March 22, 2013) ##

* First attempt.
