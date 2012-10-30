var http = new XMLHttpRequest();
var default_endpoint = "http://fowllow.com/"

function get_meta(name)
 {
    var metas = document.getElementsByTagName('meta');
    var i;
    for (i = 0; i < metas.length; i++) {
        if (metas[i].getAttribute('name') == name)
        return metas[i].getAttribute('content');
    }
    return null;
}

var fowllow_user = get_meta('fowllow_user');
var fowllow_topic = get_meta('fowllow_topic');
var fowllow_endpoint = get_meta('fowllow_endpoint');
var fowllow_role = get_meta('fowllow_role');

if (!fowllow_endpoint) { fowllow_endpoint = default_endpoint}

// Guide
function report() {
    put_url(fowllow_user, fowllow_topic, window.location);
}

function put_url(name, topic, url) {
    http.open('POST', fowllow_endpoint + name + "/" + topic + "?url=" + url, true);
    http.send();
}

// Follower
function get_url(name, topic, callback) {
    http.open('GET', fowllow_endpoint + name + "/" + topic, true);
    http.onreadystatechange = function() {
        if (http.readyState == 4 && http.status == 200) {
            if (callback) {
                callback(http.responseText);
            };
        }
    }
    http.send();
}

function url_callback(url) {
    if (url != window.location) {
        window.location = url;
    }
}
function try_to_refresh() {
    get_url(fowllow_user, fowllow_topic, url_callback);
}

function poll() {
    setInterval(try_to_refresh, 500);
}

function getCookie(c_name)
{
    var i,x,y,ARRcookies=document.cookie.split(";");
    for (i=0;i<ARRcookies.length;i++) {
        x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x=x.replace(/^\s+|\s+$/g,"");
        if (x==c_name) {
            return unescape(y);
        }
    }
}

var role;

// Debug routings
var role = getCookie('slidown_role');

if (role == 'Guide') {
    report();
} else {
    poll();
}
