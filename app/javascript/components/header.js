var content = 'Order serendipitous meals from the best restaurants around';

var ele = '<span>' + content.split('').join('</span><span>') + '</span>';


$(ele).hide().appendTo('p').each(function (i) {
  $(this).delay(100 * i).css({
    display: 'inline',
    opacity: 0
  }).animate({
    opacity: 1
  }, 100);
});
