// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var page_num = 1;
var request_pending = false;
document.addEventListener("scroll", function() {
  if (request_pending) {
    return;
  }
  checkForNewDiv();
});

var checkForNewDiv = function () {
    var last_div = document.querySelector("#scroll-content > div:last-child");
    var last_div_offset = last_div.offsetTop + last_div.clientHeight;
    var page_offset = window.pageYOffset + window.innerHeight;

    if (page_offset > last_div_offset - 10) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "/feeds/next_page?page=" + page_num);
        xhr.send();
        request_pending = true;
        xhr.onreadystatechange = function() {
          var DONE = 4;
          var OK = 200;
          if (xhr.readyState == DONE) {
            if (xhr.status == OK) {
              var arr = JSON.parse(xhr.responseText);
              var arr_length = arr.length;
              for (var i = 0; i < arr_length; i++) {
                var feed_obj = arr[i];
                var feed_div = document.createElement("div");
                var feed_para = document.createElement("p");
                var title_link = document.createElement("a");
                title_link.href = feed_obj.url;
                title_link.innerHTML = feed_obj.title;
                feed_para.appendChild(title_link);
                feed_para.innerHTML += "(" + feed_obj.displayed_website + ")";
                feed_div.appendChild(feed_para);
                feed_para = document.createElement("p");
                feed_para.innerHTML = feed_obj.score + " points by " + feed_obj.created_by + feed_obj.displayed_time + " | hide | " + feed_obj.comments_count;
                feed_div.appendChild(feed_para);
                document.getElementById("scroll-content").appendChild(feed_div);
              }
              page_num++;
              var div_count = document.getElementById("scroll-content").childElementCount;
              console.log("Count: " + div_count);
              console.log("Page: " + page_num);
            }
            else {
              console.log('Error');
            }
          }
          request_pending = false;
        };
    }
};