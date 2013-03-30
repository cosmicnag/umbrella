<div class="browseDetailEach">
                    <div class="col25">
                        <img alt="" src="<%= image_url %>">
                    </div>
                    <div class="col75">
                        <div class="bookTitle"><strong><%= title %></strong></div>
                        <% if (typeof(subtitle) != 'undefined') { %>
                        <div class="bookAuthor"><em><%= subtitle %></em></div>
                        <% } %>
                        <% if (typeof(publish_date) != 'undefined') { %>
                        <div class="bookDate"><%= publish_date %></div>
                        <% } %>
                        <% if (typeof(subjects) != 'undefined') { %>
                        <div class="bookGenre"><% for (subject in subjects) { %> <%= subject %> <% } %></div>
                        <% } %>
                        <div class="bookLinkOL"><a href="http://openlibrary.org<%= key %>"> <%= key %></a></div>
                        <br>
                        <% if (typeof(description) != 'undefined') { %>
                        <div class="description"><%= description.value %></div>
                        <% } %>
                        <a href="javascript:void(0);" class="linkModal contactLender">Borrow</a>
                    </div> <!-- end col 75  -->
                    <div class="clear"></div>
                </div>
