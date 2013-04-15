<% if (has_cover) { %>
    <img alt="" src="<%= image_url %>">
       

<% } else { %>
    <div class="placeholderImg">
        <p><%= title %></p>
        <p class="smallFont"><em>Dummy author</em></p>
    </div>
<% } %>

<a href="javascript:void(0);" class="linkModal contactLender">Borrow</a>
<div class="bookLinkOL"><a href="http://openlibrary.org<%= key %>">OpenLibrary page</a></div>
