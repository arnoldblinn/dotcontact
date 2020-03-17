% include('header.tpl', title='Query')

<style type="text/css">
.wrap { 
   white-space: pre-wrap;      /* CSS3 */   
   white-space: -moz-pre-wrap; /* Firefox */    
   white-space: -pre-wrap;     /* Opera <7 */   
   white-space: -o-pre-wrap;   /* Opera 7 */    
   word-wrap: break-word;      /* IE */
}
</style>


<div id="app"></div>

<script src='https://fb.me/react-15.1.0.min.js'></script>
<script src='https://fb.me/react-dom-15.1.0.min.js'></script>

<script id="rendered-js">

var contactItems = [];
var showDetails = false;

class ContactList extends React.Component {
 
    render() {
        var emptyText = "";
        if (this.props.items.length == 0) {
            emptyText = React.createElement("span", null, "No elements");
        }

        var items = this.props.items.map((item, index) => {
           return (
               React.createElement(ContactListItem, { key: index, item: item, index: index, removeItem: this.props.removeItem, moveItemUp: this.props.moveItemUp, moveItemDown: this.props.moveItemDown, last: (index == this.props.items.length - 1) })
           );
        });

	return (
	    React.createElement("div", { }, 
		React.createElement("h2", {}, "Dot Contact Elements"),
                emptyText,
	        React.createElement("table", {}, items)
	    )
        );
    }
}

class ContactListDNS extends React.Component {

    render() {
        var x = "[";
	for (var i = 0; i < this.props.items.length; i++) {		
		x = x + "{";
		x = x + '"name": "' + this.props.items[i].name + '",';
		x = x + '"url": "' + this.props.items[i].url + '",';		
		x = x + '"icon": "'+ this.props.items[i].icon + '"';
		x = x + "}";
		if (i < this.props.items.length - 1) x = x + ","
	}
	x = x + "]";
	
        return (
            React.createElement("div", {}, 
                React.createElement("h2", null, "JSON/DNS Data"),
                React.createElement("h3", {}, "json"),
                React.createElement("span", {className: "wrap"}, x),
                React.createElement("h3", {}, "_dotcontact DNS Entry"),
                React.createElement("span", {className: "wrap"}, btoa(x)),	
            )
        );
    }
}

class ContactListItem extends React.Component {
    constructor(props) {
       super(props);
       this.onClickClose = this.onClickClose.bind(this);   
       this.onMoveUp = this.onMoveUp.bind(this);
       this.onMoveDown = this.onMoveDown.bind(this);
    }

    onClickClose() {
        var index = parseInt(this.props.index);
        this.props.removeItem(index);
    }  

    onMoveUp() {
        var index = parseInt(this.props.index);
        this.props.moveItemUp(index);
    }

    onMoveDown() {
        var index = parseInt(this.props.index);
        this.props.moveItemDown(index);
    }

    render() {
        var content = "";
        if (this.props.item.url) {
            content = React.createElement("a", { href: this.props.item.url}, this.props.item.name);
        } else {
            content = React.createElement("span", {}, this.props.item.name);
        }
	
        var imgData = "";
        if (this.props.item.icon) {
            var imgSrc = this.props.item.icon;
            imgData = React.createElement("img", {src: imgSrc, width: "30", height: "30"});
        }
	
        var cellUp;
        if (this.props.index == 0) {
            cellUp = React.createElement("td", {});
        } else {
            cellUp = React.createElement("td", {}, React.createElement("button", { type: "button", onClick: this.onMoveUp}, "Up"));
	}
	
        var cellDown;
        if (this.props.last) {
            cellDown = React.createElement("td", {});
        } else {
            cellDown = React.createElement("td", {}, React.createElement("button", { type: "button", onClick: this.onMoveDown}, "Down"));
        }
	
        return (
	    React.createElement("tr", {},
	        React.createElement("td", {}, imgData),
		React.createElement("td", {}, content),
		React.createElement("td", {}, React.createElement("button", { type: "button", className: "close", onClick: this.onClickClose }, "Delete")),
                cellUp,
                cellDown
            )
	);
    }
}


class ContactForm extends React.Component {
    constructor(props) {
        super(props);
        this.onSubmit = this.onSubmit.bind(this);
    }

    componentDidMount() {
        this.refs.itemName.focus();
    }

    onSubmit(event) {
        event.preventDefault();
        var newItemName = this.refs.itemName.value;
	var newItemUrl = this.refs.itemUrl.value;
	var newItemIcon = 'https://dotcontact.me/static/' + this.refs.itemIcon.value + '.png';

        if (newItemName) {
            this.props.addItem({ newItemName, newItemUrl, newItemIcon });
            this.refs.form.reset();
        }
    }

    render() {
        return (	
            React.createElement("form", { ref: "form", onSubmit: this.onSubmit, className: "form-inline" },	
		React.createElement("h2", {}, "Add New Dot Contact"),
  	        "Icon",
                React.createElement("br", {}),
                React.createElement("select", {ref: "itemIcon"},
	        React.createElement("option", {}, "bloggr"),
                    React.createElement("option", {}, "deviantart"),
                    React.createElement("option", {}, "digg"),
                    React.createElement("option", {}, "dribble"),
                    React.createElement("option", {}, "email"),
                    React.createElement("option", {}, "evernote"),
                    React.createElement("option", {}, "facebook"),
                    React.createElement("option", {}, "flickr"),
                    React.createElement("option", {}, "forrst"),
  		    React.createElement("option", {}, "instagram"),
		    React.createElement("option", {}, "linkedin"),
		    React.createElement("option", {}, "location"),
		    React.createElement("option", {}, "phone"),
		    React.createElement("option", {}, "pintrest"),
			React.createElement("option", {}, "rss"),
			React.createElement("option", {}, "share"),
			React.createElement("option", {}, "skype"),
			React.createElement("option", {}, "sms"),
			React.createElement("option", {}, "tumblr"),
			React.createElement("option", {}, "twitter"),
			React.createElement("option", {}, "vimeo"),
			React.createElement("option", {}, "www"),
                    React.createElement("option", {}, "youtube")			
                ),
                React.createElement("br", {}),
                "Name",
                React.createElement("br", {}),
                React.createElement("input", { type: "text", ref: "itemName", className: "form-control", placeholder: "add a new name..." }),	  
                React.createElement("br", {}),
                "URL",
                React.createElement("br", {}),
                React.createElement("input", { type: "text", ref: "itemUrl", className: "form-control", placeholder: "add a new url..."}),
                React.createElement("br", {}),
                React.createElement("button", { type: "submit", className: "btn btn-default" }, "Add")
            )
        );    
    }
}


class ContactApp extends React.Component {

    constructor(props) {
        super(props);
        this.addItem = this.addItem.bind(this);
	this.fetchItems = this.fetchItems.bind(this);
        this.removeItem = this.removeItem.bind(this);
	this.moveItemUp = this.moveItemUp.bind(this);
	this.moveItemDown = this.moveItemDown.bind(this);
	this.toggleShowDetails = this.toggleShowDetails.bind(this);
        this.state = { contactItems: contactItems, showDetails: showDetails };
    }

    addItem(contactItem, itemUrl, itemIcon) {
        contactItems.unshift({
            index: contactItems.length + 1,
            name: contactItem.newItemName,
	    url: contactItem.newItemUrl,
	    icon: contactItem.newItemIcon
	});

        this.setState({ contactItems: contactItems });
    }
  
    moveItemDown(itemIndex) {
        if (itemIndex < contactItems.length - 1) {
            var temp = contactItems[itemIndex];
            contactItems[itemIndex] = contactItems[itemIndex + 1];
            contactItems[itemIndex + 1] = temp;
            this.setState({contactItems: contactItems});
        }
    }
  
    moveItemUp(itemIndex) {
        if (itemIndex > 0) {
            var temp = contactItems[itemIndex];
            contactItems[itemIndex] = contactItems[itemIndex - 1];
            contactItems[itemIndex - 1] = temp;
            this.setState({ contactItems: contactItems});
        }
    }
  
    removeItem(itemIndex) {
        contactItems.splice(itemIndex, 1);
        this.setState({ contactItems: contactItems });
    }
  
    fetchItems2(eventData) {
        var domain = this.refs.domainName.value;
	var url = 'https://dotcontact.me/dotcontact?domain=' + domain;
	fetch(url)
		.then(response=>response.json())
		.then(data=>this.loadData(data))
		.catch(error=>this.loadData([]));
    }

    loadData2(data) {
        contactItems = data;
	this.setState({contactItems: contactItems});
    }

    fetchItems(eventData) {
        var domain = this.refs.domainName.value;
	var url = 'https://dns.google/resolve?type=txt&name=_dotcontact.' + domain;
	fetch(url)
		.then(response=>response.json())
		.then(data=>this.loadData(data))
		.catch(error=>this.loadData([]));
    }
  
    loadData(data) {
	contactItems = JSON.parse(atob(data['Answer'][0]['data'].split('"').join('')));
	this.setState({contactItems: contactItems});
    }

    toggleShowDetails(eventData) {
        showDetails = !showDetails;
    	this.setState({ showDetails: showDetails});
    }
  
    render() {

        var dnsDetails = "";
	var showDetailsButtonText;
	if (showDetails) {
	   dnsDetails = React.createElement(ContactListDNS, {items: contactItems});
	   showDetailsButtonText = "Hide DNS Details";
        } else {
	    showDetailsButtonText = "Show DNS Details";
	}

	
        return (
            React.createElement("div", { id: "main" },
                React.createElement("h1", null, "Dot Contact Editor"),
                React.createElement("h2", null, "Query Values from DNS"),
		React.createElement("input", { type: "text", ref: "domainName", placeholder: "domain name..." }),
		React.createElement("button", { type: "button", onClick: this.fetchItems}, "Query"),
                React.createElement(ContactList, { items: contactItems, removeItem: this.removeItem, moveItemUp: this.moveItemUp, moveItemDown: this.moveItemDown}),
		React.createElement("br", null),
		React.createElement("button", { type: "button", onClick: this.toggleShowDetails}, showDetailsButtonText),
		dnsDetails,
 	        React.createElement(ContactForm, { addItem: this.addItem })
            )
    )};
}


ReactDOM.render(React.createElement(ContactApp, { }), document.getElementById('app'));

</script>

% include('footer.tpl')
