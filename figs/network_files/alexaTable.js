!function(modules){var installedModules={};function __webpack_require__(moduleId){if(installedModules[moduleId])return installedModules[moduleId].exports;var module=installedModules[moduleId]={i:moduleId,l:!1,exports:{}};return modules[moduleId].call(module.exports,module,module.exports,__webpack_require__),module.l=!0,module.exports}__webpack_require__.m=modules,__webpack_require__.c=installedModules,__webpack_require__.d=function(exports,name,getter){__webpack_require__.o(exports,name)||Object.defineProperty(exports,name,{configurable:!1,enumerable:!0,get:getter})},__webpack_require__.n=function(module){var getter=module&&module.__esModule?function(){return module.default}:function(){return module};return __webpack_require__.d(getter,"a",getter),getter},__webpack_require__.o=function(object,property){return Object.prototype.hasOwnProperty.call(object,property)},__webpack_require__.p="",__webpack_require__(__webpack_require__.s=485)}({485:function(module,exports){!function($){$.fn.alexaTable=function(op){var bgVer=(""+(void 0!==Backgrid.VERSION?Backgrid.VERSION:void 0===Backgrid.requireOptions?"0.3.7":"0.2.6")).replace(/\./g,"");if($(".AlexaTable").addClass("Backgrid"+bgVer),parseInt(bgVer)>=37&&(op.columns=op.columns.map(function(col){return col.editable=Object.path(col,"editable",!1),col})),!op||!op.initial_data)return $(this);if(!op.force_has_data&&(op.force_no_data||!op.initial_data.fetch&&(!_.isArray(op.initial_data.result)||!op.initial_data.result.length))){var table_def={collection:Object.path(op,"collection",new Backbone.Collection),className:"table"+Object.path(op,"className","")+" alexaEmptyTable"};return["tagName","header","columns","row","emptyText","body","footer"].forEach(function(attribute){Object.path(op,attribute,!1)&&(table_def[attribute]=Object.path(op,attribute))}),$(this).html(new Backgrid.Grid(table_def).render().$el).append(_hhCompile($(op.no_data))())}var url=Object.path(op,"initial_data.request.url",null),mode=op.mode||(url?"server":"client"),limit=Object.path(op,"initial_data.pagination.limit",null),total=Object.path(op,"initial_data.pagination.total",null),state=op.initial_data.pagination?{pageSize:op.initial_data.pagination.perPage,totalRecords:limit&&limit<total?limit:total,currentPage:Object.path(op.initial_data.pagination,"currentPage",null),sortKey:Object.path(op.initial_data,"request.sort_by",null),order:Object.path(op.initial_data,"request.order",null),upgradeRecords:op.initial_data.pagination.total,firstPage:0}:{},$this=$(this);op.showRowNo&&(op.columns[0].alexaType&&"auto"==op.columns[0].alexaType||op.columns.unshift({name:"row",alexaType:"auto",label:"",headerCell:Backgrid.Alexa.HeaderCell.extend({className:""}),cell:Backgrid.Alexa.IndexIntegerCell,editable:!1}));var data=op.initial_data.result,obj={model:Backbone.Model.extend({}),state:state,mode:mode,queryParams:{currentPage:"page",pageSize:"per_page",totalPages:"total_pages",totalRecords:"total_entries",sortKey:"sort_by",order:"order",directions:{"-1":"ascending",1:"descending",ascending:"ascending"}},url:url},pageableCollection=new((op.pageableCollection||Backbone.PageableCollection).extend(obj))(data);op.enableShortcuts||(Backgrid.Command.prototype.moveUp=function(){return!1},Backgrid.Command.prototype.moveDown=function(){return!1},Backgrid.Command.prototype.moveLeft=function(){return!1},Backgrid.Command.prototype.moveRight=function(){return!1}),op.initial_data.fetch&&(ALEXA.axDialog.waiting.open(),pageableCollection.fetch().always(function(){ALEXA.axDialog.waiting.close()}));var els=[],pageableGrid=new Backgrid.Grid({className:op.overrideClass?op.overrideClass:"alexaTable table"+(op.className?op.className:""),columns:op.columns,row:op.row?op.row:Backgrid.Row,tagName:op.tagName||"table",header:op.header||Backgrid.Header,body:op.body||Backgrid.Body,collection:pageableCollection});if(els.push(pageableGrid.render().$el),op.initial_data.pagination){var sort_key=op.initial_data.pagination.sort_key,order=op.initial_data.pagination.order;sort_key&&order&&(console.log(sort_key,order),pageableCollection.trigger("backgrid:sort",sort_key,order,null,pageableCollection))}if(op.initial_data.pagination){var paginator=op.paginator?new op.paginator({collection:pageableCollection}):new Backgrid.Alexa.Paginator({collection:pageableCollection});paginator.$table=pageableGrid.$el,els.push(paginator.render().$el)}return $this.html(els),$this.data("alexaTable:data",pageableGrid),$this};var Alexa=Backgrid.Alexa=Backgrid.Alexa?Backgrid.Alexa:{},bExtend=Backbone.Model.extend;Alexa.getParentFunc=function(funcName,myobj,args){for(var objProto=myobj.constructor.__super__,func=myobj[funcName],bFound=!1;!bFound&&func!=args.callee||func==args.callee;)func==args.callee&&(bFound=!0),func=objProto[funcName],objProto=objProto.constructor.__super__;return func},Alexa.colname=function(bgcell){bgcell.$el.addClass("colname-"+bgcell.column.get("name"))},Alexa.callParent=function(funcName,myobj,args,empty){try{return Alexa.getParentFunc(funcName,myobj,args).apply(myobj,args)}catch(e){}return empty},Alexa.NumberFormatter=bExtend.call(Backgrid.NumberFormatter,{fromRaw:function(number,model){var val=Alexa.callParent("fromRaw",this,arguments,"");return""!==val?val:"-"}}),Alexa.IndexNumberFormatter=bExtend.call(Backgrid.NumberFormatter,{fromRaw:function(number,model){var val=Alexa.callParent("fromRaw",this,arguments,"");return""!==val?val+".":"-"}}),Alexa.NonEmptyStringFormatter=bExtend.call(Backgrid.NumberFormatter,{fromRaw:function(val){return""!==val?val:"[blank]"}}),Alexa.PercentageFormatter=bExtend.call(Backgrid.NumberFormatter,{fromRaw:function(number,model){return this.constructor.__super__.fromRaw.apply(this,arguments)+"%"}}),Alexa.NumberCell=Backgrid.NumberCell.extend({decimals:0,className:"align-right pad-right",formatter:Alexa.NumberFormatter,template:null,render:function(){this.$el.empty(),Alexa.colname(this),this.$el.addClass("anumcell");var rawValue=this.model.get(this.column.get("name")),value=this.formatter.fromRaw(rawValue);return this.$el.attr("hasVal",0!=rawValue),"-"!=value||null==this.template?Alexa.callParent("render",this,arguments,this):(this.$el.html(this.template(this)),this.delegateEvents(),this)}}),Alexa.NumberCellLeft=Backgrid.Alexa.NumberCell.extend({className:""}),Alexa.IndexIntegerCell=Backgrid.NumberCell.extend({decimals:0,render:function(){return Alexa.callParent("render",this,arguments),Alexa.colname(this),this},className:"align-right",formatter:Alexa.IndexNumberFormatter}),Alexa.StringCell=Backgrid.StringCell.extend({template:Handlebars.compile("<i>[blank]</i>"),render:function(){this.$el.empty(),Alexa.colname(this),this.$el.addClass("astrcell");for(var value=this.formatter.fromRaw(this.model.get(this.column.get("name"))),ret=this,i=80;i>10;){var re=new RegExp("[^\\s]{"+i+"}");value.match(re)&&(this.$el.addClass("breakall-"+i),i=0),i/=2}return value?ret=Alexa.callParent("render",this,arguments,this):this.$el.html(this.template(this)),this.delegateEvents(),ret}}),Alexa.StringWithTitleCell=Backgrid.StringCell.extend({render:function(){this.$el.empty();var text=this.formatter.fromRaw(this.model.get(this.column.get("name")));return this.$el.text(text),this.$el.attr("title",text),this.delegateEvents(),this}}),Alexa.IconCell=Backgrid.Cell.extend({tag:"span",icon:{true:"fa-check",false:"fa-times"},render:function(){this.$el.empty(),Alexa.colname(this);var tag=this.tag,val=this.formatter.fromRaw(this.model.get(this.column.get("name"))?"true":"false"),icon=this.icon[val];return this.$el.append($("<"+tag+">",{class:icon+" icon-cell-"+val})),this}}),Alexa.BooleanCell=Backgrid.Cell.extend({className:"text-center",render:function(){return this.$el.empty(),Alexa.colname(this),this.$el.append($("<span>",{class:"boolean-cell-"+this.formatter.fromRaw(this.model.get(this.column.get("name"))?"true":"false")}).append("&nbsp;")),this}}),Alexa.PercentageNumberCell=Backgrid.NumberCell.extend({className:"align-right",formatter:Alexa.PercentageFormatter}),Alexa.PercentageBarFewManyCell=Backgrid.IntegerCell.extend({className:"align-right",template:_hhCompile($("#PercentageBarFewManyCell")),template_partials:{bar:_hhCompile($("#PercentageBarPartial"))},render:function(){this.$el.empty();var model=this.model,val=this.formatter.fromRaw(model.get(this.column.get("name")),model);return this.$el.html(this.template({val:val,offset:100-val},{partials:this.template_partials})),this.delegateEvents(),this}}),Alexa.PercentageBarNumericCell=Alexa.PercentageBarFewManyCell.extend({className:"align-left",template:_hhCompile($("#PercentageBarNumericCell"))}),Alexa.UriCell=Backgrid.UriCell.extend({formatter:new Backgrid.StringFormatter,render:function(){this.$el.empty(),Alexa.colname(this);var rawValue=this.model.get(this.column.get("name"));if($.isArray(rawValue)){var self=this;rawValue.forEach(function(l){self.$el.append(self.link(l)).append("&nbsp;")})}else this.$el.append(this.link(rawValue));return this.delegateEvents(),this},href:function(rawValue){return rawValue},link:function(rawValue,label){var formattedValue=this.formatter.fromRaw(rawValue,this.model);return $("<a>",{tabIndex:-1,href:this.href(rawValue),title:this.title||this.href(rawValue),target:this.target,class:this.anchorClassName?this.anchorClassName:""}).text(this.text||formattedValue)}}),Alexa.SiteInfoUriCell=Alexa.UriCell.extend({className:"cell siteinfo-uri-cell align-left",render:function(){this.$el.empty(),Alexa.colname(this);var rawValue=this.model.get(this.column.get("name")),linkspan=$("<span>",{class:"link"}),url=window.location.origin+"/siteinfo/"+rawValue;return linkspan.append($("<a>",{class:"",tabindex:"-1",target:"_blank",href:url}).append(rawValue)),this.$el.append(linkspan),this.delegateEvents(),this}}),Alexa.ExternalUri=Backgrid.Alexa.UriCell.extend({className:"linksinExternal",target:"_blank",link:function(rawVal,label){var link=Alexa.callParent("link",this,arguments),linkspan=$("<span>",{class:"link"});return void 0!==label&&("string"==typeof label?linkspan.append($.parseHTML(label)):linkspan.append(label)),linkspan.append(link).append("&nbsp;"),$("<div>",{class:"ellipses2"}).append($("<div>",{class:"offsite2"}).append(linkspan)).append("&nbsp;<br>")},href:function(raw){var url=URI(raw);return url.protocol()||url.protocol("http"),url.href()}}),Alexa.HeaderCell=Backgrid.HeaderCell.extend({className:"align-left",render:function(){this.$el.empty(),Alexa.colname(this),this.column.get("sortable")?(this.$el.addClass("sortable"),this.$el.append($("<a>").append([$.parseHTML(this.column.get("label")),$("<b>",{class:"sort-caret"})]))):this.$el.append($.parseHTML(this.column.get("label")));var tooltipId=this.column.get("tooltipId")||this.column.get("name"),tooltip=$("#"+tooltipId+"-tooltip");return this.$el.append(_hhCompile(tooltip)()),this.delegateEvents(),this}}),Alexa.NewHeaderCell=Alexa.HeaderCell.extend({className:"align-left resizable",template:'<a><span>{{content}}</span>{{#if tooltip}}{{{tooltip}}}{{/if}}{{#if sortable}}<b class="sort-caret"></b>{{/if}}</a>',tooltipTemplate:'<span class="WhatsThis top"><i class="fa fa-question-circle" aria-hidden="true"></i><span class="container">{{tooltipText}}</span></span>',generateTooltip:function(){var tooltipId=this.column.get("tooltipId")||this.column.get("name"),tooltip=$("#"+tooltipId+"-tooltip"),tooltipHtml="";if(tooltip.length)tooltipHtml=_hhCompile(tooltip)();else if(this.column.get("tooltip")){var tooltipTemplate=this.column.get("tooltipTemplate")||this.tooltipTemplate;tooltipHtml=Handlebars.compile(tooltipTemplate)({tooltipText:this.column.get("tooltip")})}return tooltipHtml},render:function(){this.$el.empty(),Alexa.colname(this);var template=Handlebars.compile(this.template),data={content:this.column.get("label"),tooltip:this.generateTooltip(),sortable:this.column.get("sortable")};return this.column.get("sortable")&&this.$el.addClass("sortable"),this.$el.append(template(data)),this.delegateEvents(),this}}),Alexa.StringWithTitleCell=Backgrid.StringCell.extend({render:function(){this.$el.empty();var text=this.formatter.fromRaw(this.model.get(this.column.get("name")));return this.$el.text(text),this.$el.attr("title",text),this.delegateEvents(),this}}),Alexa.ExpandCell=Backgrid.Cell.extend({events:{click:"triggerRowExpand"},triggerRowExpand:function(){this.expanded=!this.expanded,this.model.trigger("backgrid:row:expand",this.model,this.expanded)}}),Alexa.ExpandableRow=Backgrid.Row.extend({events:{click:"expandRowMaybe"},className:"row-collapsed",expandRowMaybe:function(e){this.$el.find("td[hasVal=false]:last-child").length>0||(this.expanded=!this.expanded,this.$expanded_row||(this.create_expanded_row(),this.renderExpanded(),this.$expanded_row.wrap("<tr class='expandable-row'>")),this.expanded?(this.$expanded_row.parents(".expandable-row").show(),$(e.target).parent("tr").removeClass("row-collapsed").addClass("row-expanded")):(this.$expanded_row.parents(".expandable-row").hide(),$(e.target).parent("tr").removeClass("row-expanded").addClass("row-collapsed")))},create_expanded_row:function(){this.$expanded_row;var l=this.$el.children().length;this.$expanded_row=$("<td>",{class:"expanded-cell",colspan:l}),this.$el.after(this.$expanded_row)}}),Alexa.HeaderCellRight=Alexa.HeaderCell.extend({className:"align-right"}),Alexa.HeaderCellCenter=Alexa.HeaderCell.extend({className:"text-center"}),Alexa.HeaderDivCell=Alexa.HeaderCell.extend({tagName:"div",className:"align-left cell",events:{"click a":"onClickEx"},onClickEx:function(e){var directions=["ascending","descending",null],oldDirection=this.column.get("direction"),direction=directions[(directions.indexOf(oldDirection)+1)%directions.length];this.column.set("direction",direction),this.onClick(e)}}),Alexa.DivRow=Backgrid.Row.extend({tagName:"div",className:"rows"}),Alexa.PercentageBarNumericDivCell=Alexa.PercentageBarNumericCell.extend({tagName:"div",className:"cell"}),Alexa.DivCell=Backgrid.Cell.extend({tagName:"div",className:"cell"}),Alexa.IntegerDivCell=Backgrid.IntegerCell.extend({tagName:"div",className:"cell"}),Alexa.StringDivCell=Backgrid.StringCell.extend({tagName:"div",className:"cell"}),Alexa.SelectDivCell=Backgrid.SelectCell.extend({tagName:"div",className:"cell"}),Alexa.HeaderDivRow=Backgrid.HeaderRow.extend({tagName:"div",className:"rows"}),Alexa.DivBody=Backgrid.Body.extend({tagName:"div",className:"tbody"}),Alexa.DivHeader=Backgrid.Header.extend({tagName:"div",className:"thead",initialize:function(options){this.columns=options.columns,this.columns instanceof Backbone.Collection||(this.columns=new Columns(this.columns)),this.row=new Alexa.HeaderDivRow({columns:this.columns,collection:this.collection})}});var $us=$("<div>");ALEXA.upgradeLock($us,{placement:"top",template:"( <%= lock %> <span class='upsell-total'>{{~iFormat results.upgradeRecords~}}</span> results available )"});var paginatTemplate=Handlebars.compile('<div class="pageNav text-right">{{#if results.total}}<span class="alexa-pagination pages-list">{{~#each handles~}}{{~#if prev~}}<a href="#" class="previous" data-page="{{~page~}}" title="Previous">&nbsp;</a>{{~/if~}}{{~#if link~}}<a href="#" class="pagination-page" data-page="{{~page~}}">{{~iFormat page~}}</a>{{~/if~}}{{~#if current~}}<span class="pagination-current">{{iFormat page}}</span>{{~/if~}}{{~#if div~}}<span class="dividor">⋅⋅⋅</span>{{~/if~}}{{~#if next~}}<a href="#" class="next" data-page="{{~page~}}" title="Next">&nbsp;</a>{{~/if~}}{{~#if prevDisabled~}}<span class="previous-disabled">{{page}}</span>{{~/if~}}{{~#if nextDisabled~}}<span class="next-disabled">{{page}}</span>{{~/if~}}{{~/each~}}</span><span class="alexa-pagination current-page">{{~#if handles~}}<span class="pagination-page pagination-separator">&nbsp;</span>{{~/if~}}{{~prefix~}}&nbsp;<b>{{iFormat results.from}}</b>&nbsp;-&nbsp;<b>{{iFormat results.to}}</b> {{~#unless results.upgradeRecords~}}&nbsp;of&nbsp;<b>{{iFormat results.total}}</b>{{~/unless~}}{{~#if results.upgradeRecords~}}&nbsp;'+$us.html()+"{{~/if~}}</span>{{/if}}</div>");Handlebars.registerHelper("iFormat",function(number){return _.isNull(number)||_.isUndefined(number)?"":number.commafy()});var AlexaPaginatorOpts={className:"table-paging",_prefix:"Results",template:paginatTemplate,_pages:function(pageInfo){var firstPage=pageInfo.firstPage,lastPage=pageInfo.lastPage,currentPage=pageInfo.currentPage;if(firstPage===lastPage)return[];var previousPage=Math.max(currentPage-1,firstPage),nextPage=Math.min(currentPage+1,lastPage),startPage=Math.max(Math.min(currentPage-2,lastPage-5),firstPage),endPage=Math.min(Math.max(currentPage+2,5),lastPage),pages=[];firstPage!==currentPage?pages.push({page:previousPage,prev:!0}):pages.push({prevDisabled:!0}),firstPage!==startPage&&pages.push({page:firstPage,link:!0}),currentPage>3&&lastPage>4&&pages.push({div:!0});for(var i=startPage;i<endPage+1;i++)i===currentPage?pages.push({page:i,current:!0}):pages.push({page:i,link:!0});return lastPage>currentPage+3&&lastPage>4&&pages.push({div:!0}),endPage!==lastPage&&pages.push({page:lastPage,link:!0}),lastPage>currentPage?pages.push({page:nextPage,next:!0}):lastPage===currentPage&&pages.push({nextDisabled:!0}),pages},_stateToPages:function(state){return{firstPage:0===(state=state||{}).firstPage?state.firstPage+1:state.firstPage,lastPage:state.totalRecords&&state.pageSize?Math.ceil(state.totalRecords/state.pageSize):state.lastPage,currentPage:Math.max(state.firstPage?state.currentPage:state.currentPage+1,state.firstPage),totalRecords:state.totalRecords,upgradeRecords:Object.path(state,"upgradeRecords",null),pageSize:state.pageSize}},_results:function(pageInfo){var ret={from:(pageInfo.currentPage-1)*pageInfo.pageSize+1,to:Math.min(pageInfo.currentPage*pageInfo.pageSize,pageInfo.totalRecords),total:pageInfo.totalRecords};return pageInfo.upgradeRecords&&pageInfo.upgradeRecords>pageInfo.totalRecords&&(ret.upgradeRecords=pageInfo.upgradeRecords),ret},makeHandles:function(){var pageInfo=this._stateToPages(this.collection.state);return{prefix:this._prefix,handles:this._pages(pageInfo),results:this._results(pageInfo)}},render:function(){return this.$el.empty(),this.$el.append(this.template(this.makeHandles())),this.delegateEvents(),this.$table.trigger("alexa:table:render_complete"),this},changePage:function(e){e.preventDefault();var $li=$(e.target).parent();if(!$li.hasClass("active")&&!$li.hasClass("disabled")){var label=parseInt($(e.target).data("page"),10),collection=this.collection,$table=this.$table;if(label){var dis=this,pageIndex=0===collection.state.firstPage?label-1:label,successFunc=function(){$table.trigger("alexa:table:receive_page",pageIndex),ALEXA.axDialog.waiting.close(),dis.render()};$table.trigger("alexa:table:request_page",pageIndex),ALEXA.axDialog.waiting.open(),"client"===collection.mode?(collection.getPage(pageIndex,{fetch:!1}),successFunc()):collection.getPage(pageIndex,{success:successFunc})}}}};Alexa.Paginator=Backgrid.Extension.Paginator.extend(AlexaPaginatorOpts);function _hhCompile($el){return $el instanceof $&&$el.length?Handlebars.compile($el.html()):Handlebars.compile("")}Alexa.NoEndPaginator=Alexa.Paginator.extend({_pages:function(pageInfo){return Alexa.Paginator.prototype._pages.call(this,pageInfo).filter(function(p){return!(p.page==pageInfo.lastPage&&p.link)})}}),Alexa.NoPaginator=Alexa.Paginator.extend({render:function(pageInfo){return this.$el.empty(),this.delegateEvents(),this.$table.trigger("alexa:table:render_complete"),this}}),Alexa.DefaultHeaderCell=Backgrid.HeaderCell.extend({events:{"click a":"onClick"},render:function(){this.$el.empty(),Alexa.colname(this);var label,column=this.column;return label=Backgrid.callByNeed(column.sortable(),column,this.collection)?$("<a>").text(column.get("label")).append("<span class='sort-caret' aria-hidden='true'></span>"):document.createTextNode(column.get("label")),this.$el.append(label),this.$el.addClass(column.get("name")),this.$el.addClass(column.get("direction")),this.delegateEvents(),this}}),Alexa.PageHandle=Backgrid.Extension.PageHandle,Alexa.DefaultPaginator=Backgrid.Extension.Paginator.extend({_prefix:"Results",className:"table-paging",pageHandle:Alexa.PageHandle,windowSize:5,goBackFirstOnSort:!0,controls:{rewind:null,fastForward:null},_stateToPages:Alexa.Paginator.prototype._stateToPages,_results:function(pageInfo){return{from:(pageInfo.currentPage-1)*pageInfo.pageSize+1,to:Math.min(pageInfo.currentPage*pageInfo.pageSize,pageInfo.totalRecords),total:pageInfo.totalRecords}},getPaginationInfo:function(){var pageInfo=this._stateToPages(this.collection.state);return{prefix:this._prefix,results:this._results(pageInfo)}},renderText:function(){var info=this.getPaginationInfo();return $("<span/>").append(info.prefix+" <strong>"+info.results.from+" - "+info.results.to+"</strong> of <strong>"+Object.path(info,"results.total",0).commafy()+"</strong>")},renderThese:function(handles,currentPageNo){return function(ul,testFunc){_(handles).filter(testFunc).forEach(function(handle){var rendered=handle.render();handle.pageIndex===currentPageNo-1?rendered.$el.children().first().addClass("pagination-current"):handle.isRewind||handle.isBack||handle.isForward||handle.isFastForward||rendered.$el.children().first().addClass("pagination-page"),$(ul).append(rendered.el)})}},render:function(){if(this.$el.empty(),this.renderMultiplePagesOnly&&this.collection.state.totalPages<=1)return this;var pageState=this._stateToPages(this.collection.state),div=document.createElement("div");div.className="pageNav text-right";var ul=document.createElement("ul");ul.className="alexa-pagination pages-list",_.each(this.handles,function(handle){handle.remove()});var hand,handles=this.handles=this.makeHandles(),renderThese=this.renderThese(handles,pageState.currentPage);(renderThese(ul,function(hand){return hand.isRewind||hand.isBack}),pageState.currentPage>this.windowSize)&&((hand=new this.pageHandle({collection:this.collection,pageIndex:0}).render()).$el.children().first().addClass("pagination-page"),$(ul).append(hand.el),$(ul).append('<span class="dividor">&hellip;</span>'));(renderThese(ul,function(hand){return!(hand.isRewind||hand.isBack||hand.isForward||hand.isFastForward)}),pageState.currentPage<pageState.lastPage-this.windowSize)&&((hand=new this.pageHandle({collection:this.collection,pageIndex:pageState.lastPage-1}).render()).$el.children().first().addClass("pagination-page"),$(ul).append('<span class="dividor">&hellip;</span>'),$(ul).append(hand.el));return renderThese(ul,function(hand){return hand.isForward||hand.isFastForward}),$(div).append(ul),$(div).append(this.renderText()),pageState.upgradeRecords>pageState.totalRecords&&ALEXA.upgradeLock(div,{placement:"top",template:"( <%= lock %> "+pageState.totalRecords.commafy()+" results available )"}),this.$el.append(div),this.$table.trigger("alexa:table:render_complete"),this}}),Alexa.DefaultPageableCollection=Backbone.PageableCollection.extend({getPage:function(index,options){"client"!=this.mode&&ALEXA.axDialog.waiting.open(),options&&(options.success=function(){ALEXA.axDialog.waiting.close()}),Backbone.PageableCollection.prototype.getPage.apply(this,arguments)}}),Alexa.SpanningHeaderDivRow=Alexa.HeaderDivRow.extend({render:function(){this.$el.empty();for(var fragment=document.createDocumentFragment(),groups=_.groupBy(this.cells,function(cell){return cell.column.get("label")}),i=0;i<this.cells.length;i++){var cell=this.cells[i],this_group=groups[cell.column.get("label")];this_group&&(1===this_group.length?(fragment.appendChild(cell.render().el),cell.column.get("renderable")||cell.$el.hide()):this_group.length>1&&(_.each(groups[cell.column.get("label")],function(cell,index){fragment.appendChild(cell.render().el),cell.column.get("renderable")||cell.$el.hide(),0===index&&cell.$el.find(".multi-column-div").css("width",this_group.length+"00%")}),delete groups[cell.column.get("label")]))}return this.el.appendChild(fragment),this.delegateEvents(),this}}),Alexa.SpanningHeader=Alexa.DivHeader.extend({initialize:function(options){["columns","collection"].forEach(function(key){if(void 0===options[key])throw new TypeError("'"+key+"' is required")}),this.columns=options.columns,this.columns instanceof Backbone.Collection||(this.columns=new Columns(this.columns)),this.row=new Alexa.SpanningHeaderDivRow({columns:this.columns,collection:this.collection})}})}(jQuery)}});