<form action="" class="formModal" id="formBorrow">
    <h5 class="serif">Borrow</h5>
    <p class="serif"> <a class="linkStyling" target="_blank" href="http://openlibrary.org<%= key %>"><%= title %></a></p>
    <% if (author_names.length > 0) { var names = author_names.join(','); %>
        <p class="bookAuthor"><%= names %></p>
    <% } %>


    <br>
    <label for="">Message:</label> <br> <textarea id="message" /><br />
    <p>
        Lenders: <br />
            <div class="lendersContainer">
            <% for (var i=0; i<lenders.length;i++) { var lender = lenders[i]; %>
            <div class="lenderContainer">
                <p><%= lender.name %> <input type="checkbox" checked="checked" class="lenderCheckbox" id="lender<%= lender.id %>" data-id="<%= lender.id %>" /></p>
                <p class="smallerFont"><%= lender.neighbourhood %></p>
                <p class="smallerFont"><%= lender.lending_policy %></p>
            </div>
            <% } %>
            </div>
    </p>
    <input type="submit" value="Submit" />
</form>
