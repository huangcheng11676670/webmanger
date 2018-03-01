$.fn.myselect = function(zNodes, myonClick){
    if(this.hasClass("myselectstyle")){
        let inputID = this.attr("id");
        let inputValue = this.attr("value");
        this.hide();

        let comboboxString = '<input type="text" class="form-control" readonly="true" id="'+inputID+'_label" value="选择城市"><div class="input-group-btn "><button type="button" class="btn btn-default" onClick="$(\'#'+inputID+'_tree_div\').toggle();"><span class="caret"></span></button></div><div id="'+inputID+'_tree_div" class="menuContent dropdown-menu" style="display:none; position: absolute;width: 338px;"><div onClick="$(\'#'+inputID+'_tree_div\').hide();" style="padding-right:5px;"><button type="button" class="close" aria-hidden="true">&times;</button></div><ul id="'+inputID+'_tree_show" class="ztree" style="margin-top:0; width:160px;"></ul></div>';
        $(comboboxString).insertAfter(this);
        _defaultSetting  = {
            view: {
                dblClickExpand: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: function(e, treeId, treeNode){
                    $("#"+inputID+"_tree_div").hide()
                    $("#"+inputID+"_label").val(treeNode.name);
                    $("#"+inputID).val(treeNode.id);
                    myonClick();
                }
            },
        };

        $.each(zNodes, function(i, item){
            if(inputValue != null && item.id == parseInt(inputValue)){
                $("#"+inputID+"_label").val(item.name);
            }
        });
        //$.extend(_defaultSetting, multiSetting);
        $.fn.zTree.init($("#"+inputID+"_tree_show"), _defaultSetting, zNodes);
    }
}