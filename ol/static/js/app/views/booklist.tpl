<div class="browseListEach">
    <div class="">
        <div class="bookTitle">
            <strong><%= title %></strong>
        </div>
        <div class="bookAuthor"><em><%= subtitle %></em></div>
        <% if (author_names.length > 0) { var names = author_names.join(','); %>
            <p class="bookAuthor"><%= names %></p>
        <% } %>
        <div class="bookLinkOL"><a href="http://openlibrary.org<%= key %>" target="_blank">OL Link</a></div>
        <a href="javascript:void(0);" class="linkModal contactLender">
        Borrow</a>
    </div>
        
        
</div>
