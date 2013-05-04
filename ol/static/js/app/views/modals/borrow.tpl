<form action="" class="formModal" id="formBorrow">
    <h5 class="serif"> Borrow</h5>
    <p class="serif"> <%= title %> </p>
    <br>
    <label for="">Message:</label> <br> <textarea id="message" /><br />
    <p>
        Lenders: <br />
            <% for (var i=0; i<lenders.length;i++) { var lender = lenders[i]; %>
            <%= lender.name %> <input type="checkbox" checked="checked" class="lenderCheckbox" id="lender<%= lender.id %>" data-id="<%= lender.id %>" />
            <% } %>
    </p>
    <input type="submit" value="Submit" />
</form>
