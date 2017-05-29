---
layout:       post
categories:   development
tags:         [javascript, fancybox2, blogger, blogspot]
title:        Add fancyBox2 to Blogger/BlogSpot
feature_img:
  source: posts/2015/11/add-fancybox2-to-blogger-blogspot-0.png
  width:  100
  height: 100
sitemap:
  lastmod:    2016-11-27T20:30:35
  priority:   0.5
  changefreq: monthly
  exclude:    'no'
uuid: 5308f3f3-386c-40e0-8601-f2d0f7adb8e2
---

If you use Blogger platform by default you have lightBox.
For yet it is buggy on mobile devices. Of course it would be possible to use crutches CSS. But I decided to just change it to fancyBox.
It's very easy.

**Step 1:**
Go to "Settings › Posts and comments"
And swich-off lightBox

<img src="/assets/posts/2015/11/add-fancybox2-to-blogger-blogspot-1.png">

**Step 2:**
Go to Template tab and click "Edit HTML"

<img src="/assets/posts/2015/11/add-fancybox2-to-blogger-blogspot-2.png">

**Step 3:**
Insert before tag  `</body>` script below, and save template.

```xml
<!-- fancyBox -->

<script type='text/javascript'>
  /*<![CDATA[*/
    jQuery(document).ready(function() {
      jQuery('.fancybox').fancybox();
      jQuery('a[href$=".png"], a[href$=".PNG"], a[href$=".jpg"], a[href$=".JPG"], a[href$=".gif"], a[href$=".GIF"]').each(function(){
        jQuery(this).addClass('fancybox');
      });
    });
/*]]>*/
</script>

<b:if cond='data:blog.pageType == &quot;item&quot;'>

  <script type='text/javascript'>
    /*<![CDATA[*/
      jQuery(document).ready(function() {
            jQuery('a.fancybox').each(function(){jQuery(this).attr('data-fancybox-group','gallery');});
      });
    /*]]>*/
  </script>

  <!-- script below options for mouse whell scrolling -->
  <script src='http://scripts.reatlat.net/fancyBox2/lib/jquery.mousewheel-3.0.6.pack.js' type='text/javascript'/>

</b:if>

<script src='http://scripts.reatlat.net/fancyBox2/source/jquery.fancybox.js' type='text/javascript'/>
<link href='http://scripts.reatlat.net/fancyBox2/source/jquery.fancybox.css' media='screen' rel='stylesheet' type='text/css'/>

<!-- /fancyBox -->
```

If fancyBox does not work, you also need to connect the jQuery library

```html
<script src='http://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js'></script>
```

It's all. Have a nice day ;)