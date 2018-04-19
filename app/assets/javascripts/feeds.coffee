# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
page_num = 1
request_pending = false
document.addEventListener 'scroll', ->
  if request_pending
    return
  checkForNewDiv()
  return

checkForNewDiv = ->
  last_div = document.querySelector('#scroll-content > div:last-child')
  last_div_offset = last_div.offsetTop + last_div.clientHeight
  page_offset = window.pageYOffset + window.innerHeight
  if page_offset > last_div_offset - 10
    xhr = new XMLHttpRequest
    xhr.open 'GET', '/feeds/next_page?page=' + page_num
    xhr.send()
    request_pending = true

    xhr.onreadystatechange = ->
      DONE = 4
      OK = 200
      if xhr.readyState == DONE
        if xhr.status == OK
          arr = JSON.parse(xhr.responseText)
          arr_length = arr.length
          i = 0
          while i < arr_length
            feed_obj = arr[i]
            feed_div = document.createElement('div')
            feed_para = document.createElement('p')
            title_link = document.createElement('a')
            title_link.href = feed_obj.url
            title_link.innerHTML = feed_obj.title
            feed_para.appendChild title_link
            feed_para.innerHTML += '(' + feed_obj.displayed_website + ')'
            feed_div.appendChild feed_para
            feed_para = document.createElement('p')
            feed_para.innerHTML = feed_obj.score + ' points by ' + feed_obj.created_by + feed_obj.displayed_time + ' | hide | ' + feed_obj.comments_count
            feed_div.appendChild feed_para
            document.getElementById('scroll-content').appendChild feed_div
            i++
          page_num++
          div_count = document.getElementById('scroll-content').childElementCount
          console.log 'Count: ' + div_count
          console.log 'Page: ' + page_num
        else
          console.log 'Error'
      request_pending = false
      return

  return
