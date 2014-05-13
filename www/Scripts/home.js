var loading = false;

function initPage() {
  // on click on a feed, reload the content
  $('.feed').bind('click', function() {
    $(this).toggleClass('feed-shown');
    reloadContent();
  });

  // When scrolling to the bottom of the page, reload
  $(window).scroll(function() {
    if (loading || !$('#btnMore')) return;
    var scrollTop = $(window).scrollTop();
    var screenheight = $(window).height();
    var max = $(document.body).height() - screenheight;
    if (max < 0) return;
    if (max - scrollTop <= 300)
      $('#btnMore').click();
  });

  loadContent();
}

function reloadContent() {
  loading = true;
  // remove old articles
  $('.article').remove();
  // load new ones
  loadContent();
}

function loadContent(todate) {
  loading = true;
  // teken loading icoon op de more knop
  $('.more').removeAttr('onclick').addClass('more-loading').removeClass('more').empty();

  var url = "/home.aspx/content";
  if (todate)
    url += "/" + todate;
  url += "?";
  $('.feed-shown').each(function(index) {
    url += $(this).attr('id') + "=true&";
  });

  if (typeof(pageTracker) != 'undefined')
    pageTracker._trackPageview(url);
  
  $.get(url, function(data) {
    $(data).appendTo('#articles');
    $('.more-loading').remove();
  });

  loading = false;
}



$(document).ready(initPage);