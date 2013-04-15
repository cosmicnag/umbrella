<% if (has_cover) { %>
    <img alt="" src="<%= image_url %>">
       

<% } else { %>
    <div class="placeholderImg">
        <p><%= title %></p>
        <p class="smallFont"><em>Dummy author</em></p>
    </div>
<% } %>

<div class="center gridBorrowOL">
    <a class="bookLinkOL" href="http://openlibrary.org<%= key %>">OL Link</a>
    <a href="javascript:void(0);" class="linkModal contactLender">Borrow</a>
</div>
