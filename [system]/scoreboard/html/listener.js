$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
        var players = $('#wrap').length;
        buf.find('table').append("<tr class=\"heading\"><th>ID</th><th>Name</th><th><div id='playerbox'>" + item.count + "</div></th></tr>");
        if (item.meta && item.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        buf.find('table').append(item.text);
        $('#wrap').show();
    }, false);
});