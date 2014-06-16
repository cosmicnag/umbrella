
<div id="sortCollections">
    <input type="" id="querystring" placeholder="Find" class="fontCondensed">
    <input type="text" id="author" placeholder="Author" />
    <input type="text" id="genre" placeholder="Subjects" />
 
        <select id="lender">
            <option value="all">All Lenders</option>
        </select>

        <!--<span class="reset" id="search">Search</span>-->
        <span class="reset" id="reset">Reset</span>

        <span id="resultsLoading">
            <img src="/static/img/loader-umbrella-search.gif" />
        </span>
    <div class="clear"></div>
    </div> <!-- end sort collections  -->

    <div id="pagination" class="floatLeft">
        <a href="" id="prevPage">&lt;&lt; Prev</a> 
        <a href="" id="nextPage">Next &gt;&gt;</a>
    </div>


<div class="listGridView">
<select id="sort" style="width: 76px; position: absolute; opacity: 0; height: 20px; font-size: 14.4px;" name="" class="selectSort hasCustomSelect">
    <option value="-_id">Newest</option>
    <option value="+_id">Oldest</option>
    <option value="+title">A-Z</option>
    <option value="-title">Z-A</option>
</select><span style="display: inline-block;" class="customSelect mySelectBoxClass selectSort"><span style="width: 71px; display: inline-block;" class="customSelectInner">&nbsp;</span></span>

<a href="javascript:void(0);" id="detailview" class="linkDetailsView">
    <div class="detailView">
    <div>
        <span></span>
        <span></span>
    </div>
    <div>
        <span></span>
        <span></span>
    </div>
    <div>
        <span></span>
        <span></span>
    </div>

    <p class="tooltip">Detail View</p>
    </div>
</a>

<a href="javascript:void(0);" id="listview" class="linkListView">
    <div class="listView">
        <div></div>
        <div></div>
        <div></div>
        <p class="tooltip">List View</p>
    </div>
</a>  <!-- change this later  -->

<a href="javascript:void(0);" id="gridview" class="linkGridView">
    <div class="gridView">
        <div>
            <span></span>
            <span></span>
            <span></span>
        </div>
        <div>
            <span></span>
            <span></span>
            <span></span>
        </div>
        <div>
            <span></span>
            <span></span>
            <span></span>
        </div>
        <p class="tooltip">Grid View</p>
    </div>
</a>

</div> <!-- end listGridView  -->    
<div class="clear"></div>
