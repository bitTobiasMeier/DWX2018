declare var $;
function postToServer() {    
    $('#postResult').text('');
    var mydata = $('#postData').val();
    var url = $('#postAddress').val();
    var result = $.ajax(url, {
        data: mydata,
        contentType: 'application/json',
        type: 'POST',
        success: function (msg) {
            $('#postResult').css('color', 'green');
            $('#postResult').text(JSON.stringify(msg,null,4));
        },
        error: function (err) {
            $('#postResult').css('color', 'red');
            $('#postResult').text(JSON.stringify(err));
        }
    })
}

function getFromServer() {
    $('#getResult').text('');    
    var url = $('#getAddress').val();
    var result = $.ajax(url, {        
        contentType: 'application/json',
        type: 'GET',
        success: function (msg) {
            $('#getResult').css('color', 'green');
            $('#getResult').text(JSON.stringify(msg,null,4));
        },
        error: function (err) {
            $('#getResult').css('color', 'red');
            $('#getResult').text(JSON.stringify(err));
        }
    })
}

function getAllFromServer() {
    $('#getAllResult').text('');
    var url = $('#getAllAddress').val();
    var result = $.ajax(url, {
        contentType: 'application/json',
        type: 'GET',
        success: function (msg) {
            $('#getAllResult').css('color', 'green');
            var txt = JSON.stringify(msg,null,"\t");
            $('#getAllResult').text(txt);
        },
        error: function (err) {
            $('#getAllResult').css('color', 'red');
            $('#getAllResult').text(JSON.stringify(err));
        }
    })
}
