% include('header.tpl', title='Query')

<h1>Query</h1>

<script src='https://dotcontact.me/static/contact.js' id="dotcontact" >
</script>

<script type="text/javascript">

function form_click() {
    var domain = document.getElementById("domain").value;

    load_contact('content', domain);
}

</script>


Domain: <input type="text" name="domain" id="domain"/>
<p/>
<input type=button value="Query" onclick="form_click();"/>


<div id='content'></div>


% include('footer.tpl')