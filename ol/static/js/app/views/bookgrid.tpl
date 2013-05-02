<% if (has_cover) { %>
    <img alt="" src="<%= image_url %>">
    <p><%= title %></p>
       

<% } else { %>
    <div class="placeholderImg">
	<img src="/static/img/placeholder.jpg" alt="placeholder-image">
       <p><%= title %></p>
    </div>
<% } %>

<div class="center gridBorrowOL">
    <a class="bookLinkOL" href="http://openlibrary.org<%= key %>">OL Link</a>
    <a href="javascript:void(0);" class="linkModal contactLender">Borrow</a>
</div>
