---
layout:       post
categories:   development
tags:         [php, api, mailchimp]
title:        Adding subscribers to a list using Mailchimp's API v3
feature_img:
  source: posts/2016/11/mailchimp.png
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
---

Based on the [List Members Instance docs][0], the easiest way is to use a PUT request which according to the docs either "adds a new list member or updates the member if the email already exists on the list".

Furthermore apikey is definitely not part of the [json schema][1] and there's no point in including it in your json request.

Also, you can use CURLOPT_USERPWD for basic http auth as illustrated in below.

I'm using the following function to add and update list members. You may need to include a slightly different set of merge_fields depending on your list parameters.

```php
<?php
/**
 * Adding subscribers to a list using Mailchimp's API v3
 * Based on the List Members Instance docs,
 * @link http://developer.mailchimp.com/documentation/mailchimp/reference/lists/members/
 */

$data = [
    'email'     => 'angelina.jolie@example.com',
    'status'    => 'subscribed',
    'firstname' => 'Angelina',
    'lastname'  => 'Jolie'
];

syncMailchimp($data);

function syncMailchimp($data) {
    $apiKey = 'your api key';
    $listId = 'your list id';

    $memberId = md5(strtolower($data['email']));
    $dataCenter = substr($apiKey,strpos($apiKey,'-')+1);
    $url = 'https://' . $dataCenter . '.api.mailchimp.com/3.0/lists/' . $listId . '/members/' . $memberId;

    $json = json_encode([
        'email_address' => $data['email'],
        'status'        => $data['status'], // "subscribed","unsubscribed","cleaned","pending"
        'merge_fields'  => [
            'FNAME'     => $data['firstname'],
            'LNAME'     => $data['lastname']
        ]
    ]);

    $ch = curl_init($url);

    curl_setopt($ch, CURLOPT_USERPWD, 'user:' . $apiKey);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $json);                                                                                                                 

    $result = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return $httpCode;
}
```
Credits to: [billynoah][2]

[0]: http://kb.mailchimp.com/api/resources/lists/members/lists-members-instance
{:rel="nofollow" target="_blank"}

[1]: https://us9.api.mailchimp.com/schema/3.0/Lists/Members/Instance.json
{:rel="nofollow" target="_blank"}

[2]: http://stackoverflow.com/users/1767412/billynoah
{:rel="nofollow" target="_blank"}