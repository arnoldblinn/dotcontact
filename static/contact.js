var script_tag = document.getElementById('dotcontact');
var domain = script_tag.getAttribute('data-domain');
var divname = script_tag.getAttribute('data-divname');

if (domain && divname) {
    load_contact(divname, domain);
}

// Define the
function load_contact(divname, domain) {
    const xhr = new XMLHttpRequest();
    //xhr.open('GET', 'https://dotcontact.me/dotcontact?domain=' + domain);
    xhr.open('GET', 'https://dns.google/resolve?type=txt&name=_dotcontact.' + domain);
    xhr.responseType = "json";
    xhr.onerror = function (e) {
   	const xhr2 = new XMLHttpRequest();
	xhr2.open('GET', 'http://dotcontact.me/dotcontact/dotcontact=' + domain);
	xhr2.responseType = "json";
	xhr2.onerror = function(e) {
	    document.getElementById(divname).innerHTML = '<p>No dot contact data found for ' + domain + '</p';
        }
	xhr2.onload = function(e) {
	    load(this.status, this.response, divname, domain);
	}
	xhr2.send();
    }
    xhr.onload = function (e) {
	//load(this.status, this.response, divname, domain);
	d = this.response['Answer'][0]['data']
	d = d.split('"').join('')
	d = atob(d);
	load(this.status, JSON.parse(d), divname, domain);
    };
    xhr.send();
}

function load(status, response, divname, domain) {
    if (status == 200) {
	if (!response || response.length == 0) {
	    document.getElementById(divname).innerHTML = '<p>No dot contact data found for ' + domain + '</p>';
	}
	else {
	    h = '';
	    for (i = 0; i < response.length; i++) {
		h = h + '<div style="display:inline-block; white-space:nowrap;">';
		if ('icon' in response[i]) {
		    h = h + '<img width="32" height="32" style="vertical-align:middle; padding: 5px;" src="' + response[i]['icon'] + '"/>';
		}
		
		if ('url' in response[i]) {
		    h = h + '<a href="' + response[i]['url'] + '">' + response[i]['name'] + '</a>';
		} else {
		    h = h + '<span>' + response[i]['name']; + '</span>';
		}
		h = h + "</div>";
	    }
			       
	    document.getElementById(divname).innerHTML = h;
	}
    } else {
	document.getElementById(divname).innerHTML = '<p>No dot contact data found for ' + domain + '</p>';
    }
}

