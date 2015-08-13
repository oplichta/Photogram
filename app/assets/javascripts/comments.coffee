# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TO DO - liking posts
$(document).ready ->
  $('.glyphicon').click ->
    $(this).toggleClass 'glyphicon-heart-empty'

  $('.more-comments').click ->
    $(this).on 'ajax:success', (event, data, status, xhr) ->
      postId = $(this).data('post-id')
      $('#comments_' + postId).html data
      $('#comments-paginator-' + postId).html '<a id=\'more-comments\' data-post-id=' + postId + 'data-type=\'html\' data-remote=\'true\' href=\'/posts/' + postId + '/comments>show more comments</a>'
      return
    return
  return
