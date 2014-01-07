# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->  
  # 验证码刷新  
  $("img[alt='captcha']").each (index, item) ->  
    item.title = '看不清？点击刷新'  
  $("img[alt='captcha']").bind 'click', (event) ->  
    this.src = this.src + '?'
