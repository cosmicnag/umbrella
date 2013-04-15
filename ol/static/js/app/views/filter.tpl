<div id="sortCollections">
    <input type="text" id="author" placeholder="Author" />
    <input type="text" id="genre" placeholder="Genre" />
 
        <select id="lender">
            <option value="all">All Lenders</option>
        </select>

        <!--<span class="reset" id="search">Search</span>-->
        <span class="reset" id="reset">Reset</span>


    <div class="clear"></div>
    </div> <!-- end sort collections  -->



<div class="listGridView">
<select id="sort" style="width: 76px; position: absolute; opacity: 0; height: 20px; font-size: 14.4px;" name="" class="selectSort hasCustomSelect">
    <option value="-_id">Newest</option>
    <option value="+_id">Oldest</option>
    <option value="+title">A-Z</option>
    <option value="-title">Z-A</option>
</select><span style="display: inline-block;" class="customSelect mySelectBoxClass selectSort"><span style="width: 71px; display: inline-block;" class="customSelectInner">&nbsp;</span></span>

<a href="javascript:void(0);" id="detailview" class="linkDetailsView">
    
    <div></div>
    <div></div>
    <div></div>
    <div></div>
    <div></div>
    <div></div>
    <p class="tooltip">Detail View</p>
</a>

<a href="javascript:void(0);" id="listview" class="linkListView">
    <div class="listView">
        <div></div>
        <div></div>
        <p class="tooltip">List View</p>
    </div>
</a>  <!-- change this later  -->

<a href="javascript:void(0);" id="gridview" class="linkGridView">
    <div class="gridView">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <p class="tooltip">Grid View</p>
    </div>
</a>

</div> <!-- end listGridView  -->    
<div class="clear"></div>
