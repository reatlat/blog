---
layout:       post
categories:   development
tags:         [cookies, google, javascript]
title:        Cookie Choices from Google with love =)
feature_img:  posts/2015/06/cookies.png
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Google created for us a wonderful simple and easy JavaScript to alert users that the site uses cookies.

Before this JavaScript was on their [website][0], but now it is not there :(

Good news for users of the [blogger][1] platform, there is no need to install the script template. Google has arranged this script at all its products, including all the blogs and websites based on the platform [Blogger][1].

This post is about how to set up a new approach to informing website visitors.
If you are the owner of the site on a platform [blogger][1] then you are lucky and have appeared at the top of the site here is an informational message.

![](/images/posts/2015/06/cookieconsent.jpg)

If you do not use cookies, and then you can disable this message but you are risking to violate privacy laws in Europe ... All you need to add in the tags `<head>.....</head>` following code ...

```html
<script>
cookieOptions = {};
</script>
```

But if you need the consent and informing users about cookies, but your site uses cookies to third parties, it is necessary to make simple customization's ... everything between tags `<head>....</head>`...

```html
<script>
document.cookie = cookieName + '=y; path=/; expires=' + expiryDate.toGMTString();
cookieOptions = {"msg": "Please note this website uses cookies enabling us to give you the best user experience.", "link": "http://www.example.com/p/cookies.html", "close": "Got it", "learn": "Learn more" };
</script>
```
After your message will have this kind of..

![]({/images/posts/2015/06/2015-07-29--1438161535_1100x147_scrot.png)

*document.cookie = cookieName + '=y; path=/; expires=' + expiryDate.toGMTString();* - this need for setting cookies path and life time.

The tags all change particular elements of the bar:
- msg = the message displayed in the box
- link = the url which clicking "Learn More" will redirect too
- learn = the text in the "Learn More" button
- close = the text in the "Got it" button
Note - the [official page][5] says the "msg" tag is actually "message", this is incorrect, changing "message" wont affect it.

Also, I post the original code CookieChoices with a little fix... cookie path=/

```html
<script>
  document.addEventListener(&#39;DOMContentLoaded&#39;, function(event) {
    cookieChoices.showCookieConsentBar(&#39;Please note this website uses cookies enabling us to give you the best user experience&#39;,
      &#39;Got it&#39;, &#39;Learn more&#39;, &#39;http://www.example.net/p/cookies.html&#39;);
  });
</script>
```

```javascript
/*
 Copyright 2014 Google Inc. All rights reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

(function(window) {

  if (!!window.cookieChoices) {
    return window.cookieChoices;
  }

  var document = window.document;
  // IE8 does not support textContent, so we should fallback to innerText.
  var supportsTextContent = 'textContent' in document.body;

  var cookieChoices = (function() {

    var cookieName = 'displayCookieConsent';
    var cookieConsentId = 'cookieChoiceInfo';
    var dismissLinkId = 'cookieChoiceDismiss';

    function _createHeaderElement(cookieText, dismissText, linkText, linkHref) {
      var butterBarStyles = 'position:fixed;width:100%;background-color:#eee;' +
          'margin:0; left:0; top:0;padding:4px;z-index:1000;text-align:center;';

      var cookieConsentElement = document.createElement('div');
      cookieConsentElement.id = cookieConsentId;
      cookieConsentElement.style.cssText = butterBarStyles;
      cookieConsentElement.appendChild(_createConsentText(cookieText));

      if (!!linkText && !!linkHref) {
        cookieConsentElement.appendChild(_createInformationLink(linkText, linkHref));
      }
      cookieConsentElement.appendChild(_createDismissLink(dismissText));
      return cookieConsentElement;
    }

    function _createDialogElement(cookieText, dismissText, linkText, linkHref) {
      var glassStyle = 'position:fixed;width:100%;height:100%;z-index:999;' +
          'top:0;left:0;opacity:0.5;filter:alpha(opacity=50);' +
          'background-color:#ccc;';
      var dialogStyle = 'z-index:1000;position:fixed;left:50%;top:50%';
      var contentStyle = 'position:relative;left:-50%;margin-top:-25%;' +
          'background-color:#fff;padding:20px;box-shadow:4px 4px 25px #888;';

      var cookieConsentElement = document.createElement('div');
      cookieConsentElement.id = cookieConsentId;

      var glassPanel = document.createElement('div');
      glassPanel.style.cssText = glassStyle;

      var content = document.createElement('div');
      content.style.cssText = contentStyle;

      var dialog = document.createElement('div');
      dialog.style.cssText = dialogStyle;

      var dismissLink = _createDismissLink(dismissText);
      dismissLink.style.display = 'block';
      dismissLink.style.textAlign = 'right';
      dismissLink.style.marginTop = '8px';

      content.appendChild(_createConsentText(cookieText));
      if (!!linkText && !!linkHref) {
        content.appendChild(_createInformationLink(linkText, linkHref));
      }
      content.appendChild(dismissLink);
      dialog.appendChild(content);
      cookieConsentElement.appendChild(glassPanel);
      cookieConsentElement.appendChild(dialog);
      return cookieConsentElement;
    }

    function _setElementText(element, text) {
      if (supportsTextContent) {
        element.textContent = text;
      } else {
        element.innerText = text;
      }
    }

    function _createConsentText(cookieText) {
      var consentText = document.createElement('span');
      _setElementText(consentText, cookieText);
      return consentText;
    }

    function _createDismissLink(dismissText) {
      var dismissLink = document.createElement('a');
      _setElementText(dismissLink, dismissText);
      dismissLink.id = dismissLinkId;
      dismissLink.href = '#';
      dismissLink.style.marginLeft = '24px';
      return dismissLink;
    }

    function _createInformationLink(linkText, linkHref) {
      var infoLink = document.createElement('a');
      _setElementText(infoLink, linkText);
      infoLink.href = linkHref;
      infoLink.target = '_blank';
      infoLink.style.marginLeft = '8px';
      return infoLink;
    }

    function _dismissLinkClick() {
      _saveUserPreference();
      _removeCookieConsent();
      return false;
    }

    function _showCookieConsent(cookieText, dismissText, linkText, linkHref, isDialog) {
      if (_shouldDisplayConsent()) {
        _removeCookieConsent();
        var consentElement = (isDialog) ?
            _createDialogElement(cookieText, dismissText, linkText, linkHref) :
            _createHeaderElement(cookieText, dismissText, linkText, linkHref);
        var fragment = document.createDocumentFragment();
        fragment.appendChild(consentElement);
        document.body.appendChild(fragment.cloneNode(true));
        document.getElementById(dismissLinkId).onclick = _dismissLinkClick;
      }
    }

    function showCookieConsentBar(cookieText, dismissText, linkText, linkHref) {
      _showCookieConsent(cookieText, dismissText, linkText, linkHref, false);
    }

    function showCookieConsentDialog(cookieText, dismissText, linkText, linkHref) {
      _showCookieConsent(cookieText, dismissText, linkText, linkHref, true);
    }

    function _removeCookieConsent() {
      var cookieChoiceElement = document.getElementById(cookieConsentId);
      if (cookieChoiceElement != null) {
        cookieChoiceElement.parentNode.removeChild(cookieChoiceElement);
      }
    }

    function _saveUserPreference() {
      // Set the cookie expiry to one year after today.
      var expiryDate = new Date();
      expiryDate.setFullYear(expiryDate.getFullYear() + 1);
      document.cookie = cookieName + '=y; path=/; expires=' + expiryDate.toGMTString();
    }

    function _shouldDisplayConsent() {
      // Display the header only if the cookie has not been set.
      return !document.cookie.match(new RegExp(cookieName + '=([^;]+)'));
    }

    var exports = {};
    exports.showCookieConsentBar = showCookieConsentBar;
    exports.showCookieConsentDialog = showCookieConsentDialog;
    return exports;
  })();

  window.cookieChoices = cookieChoices;
  return cookieChoices;
})(this);
```

[0]: https://www.cookiechoices.org/
{:rel="nofollow" target="_blank"}

[1]: http://www.blogger.com/
{:rel="nofollow" target="_blank"}

[2]: https://support.google.com/blogger/answer/6253244?p=eu_cookies_notice&hl=en&rd=100
{:rel="nofollow" target="_blank"}