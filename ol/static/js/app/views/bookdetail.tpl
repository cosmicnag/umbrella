<div class="browseDetailEach">
                    <div class="col25">
                        <% if (has_cover) { %>
                            <img alt="" src="<%= image_url %>">
                        <% } else { %>
                            <div class="placeholderImg">
			           <img src="/static/img/placeholder.jpg" alt="placeholder-image">
                            </div>
                        <% } %>

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
                        <div class="bookGenre"><% for (subject in subjects) { %> <span class="subject"><%= subjects[subject] %></span> <% } %></div>
                        <% } %>
                        <br>
                        <% if (typeof(description) != 'undefined') { %>
                        <div class="description"><%= description.value %></div>
                        <% } %>
                        <% if (typeof(contributors) != 'undefined') { %>
                        <div class="contributors">
                            <% for (var i=0; i<contributors.length; i++) { var contributor = contributors[i]; %>
                            <div class="contributor">
                                <%= contributor.role %>: 
                                <%= contributor.name %>    
                            </div>
                            <% } %>
                        </div>

                        <% } %>
                        <div class="bookLinkOL"><a href="http://openlibrary.org<%= key %>" target="_blank">OL Link</a></div>
                        <a href="javascript:void(0);" class="linkModal contactLender">Borrow</a>
                    </div> <!-- end col 75  -->
                    <div class="clear"></div>
                </div>
