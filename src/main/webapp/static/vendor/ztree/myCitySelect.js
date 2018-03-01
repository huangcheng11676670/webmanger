﻿var zNodes = [
    {id:8, pId: 0, name:"中国", open:true},{id:9, pId: 8, name:"四川省", open:true},{id:13, pId: 9, name:"成都市"},{id:15, pId: 13, name:"青羊区"},{id:18, pId: 13, name:"高新区"},{id:49, pId: 13, name:"市辖区"},{id:50, pId: 13, name:"锦江区"},{id:51, pId: 13, name:"金牛区"},{id:52, pId: 13, name:"武侯区"},{id:53, pId: 13, name:"成华区"},{id:54, pId: 13, name:"龙泉驿区"},{id:55, pId: 13, name:"青白江区"},{id:56, pId: 13, name:"新都区"},{id:57, pId: 13, name:"温江县"},{id:58, pId: 13, name:"金堂县"},{id:59, pId: 13, name:"双流县"},{id:60, pId: 13, name:"郫都区"},{id:61, pId: 13, name:"大邑县"},{id:62, pId: 13, name:"蒲江县"},{id:63, pId: 13, name:"新津县"},{id:64, pId: 13, name:"都江堰市"},{id:65, pId: 13, name:"彭州市"},{id:66, pId: 13, name:"邛崃市"},{id:67, pId: 13, name:"崇州市"},{id:30, pId: 9, name:"自贡市"},{id:68, pId: 30, name:"市辖区"},{id:69, pId: 30, name:"自流井区"},{id:70, pId: 30, name:"贡井区"},{id:71, pId: 30, name:"大安区"},{id:72, pId: 30, name:"沿滩区"},{id:73, pId: 30, name:"荣　县"},{id:74, pId: 30, name:"富顺县"},{id:31, pId: 9, name:"攀枝花市"},{id:75, pId: 31, name:"市辖区"},{id:76, pId: 31, name:"东　区"},{id:77, pId: 31, name:"西　区"},{id:78, pId: 31, name:"仁和区"},{id:79, pId: 31, name:"米易县"},{id:80, pId: 31, name:"盐边县"},{id:32, pId: 9, name:"泸州市"},{id:81, pId: 32, name:"市辖区"},{id:82, pId: 32, name:"江阳区"},{id:83, pId: 32, name:"纳溪区"},{id:84, pId: 32, name:"龙马潭区"},{id:85, pId: 32, name:"泸　县"},{id:86, pId: 32, name:"合江县"},{id:87, pId: 32, name:"叙永县"},{id:88, pId: 32, name:"古蔺县"},{id:33, pId: 9, name:"德阳市"},{id:89, pId: 33, name:"市辖区"},{id:90, pId: 33, name:"旌阳区"},{id:91, pId: 33, name:"中江县"},{id:92, pId: 33, name:"罗江县"},{id:93, pId: 33, name:"广汉市"},{id:94, pId: 33, name:"什邡市"},{id:95, pId: 33, name:"绵竹市"},{id:36, pId: 9, name:"内江市"},{id:121, pId: 36, name:"市辖区"},{id:122, pId: 36, name:"市中区"},{id:123, pId: 36, name:"东兴区"},{id:124, pId: 36, name:"威远县"},{id:125, pId: 36, name:"资中县"},{id:120, pId: 36, name:"隆昌县"},{id:37, pId: 9, name:"乐山市"},{id:126, pId: 37, name:"市辖区"},{id:127, pId: 37, name:"市中区"},{id:128, pId: 37, name:"沙湾区"},{id:129, pId: 37, name:"五通桥区"},{id:130, pId: 37, name:"金口河区"},{id:131, pId: 37, name:"犍为县"},{id:132, pId: 37, name:"井研县"},{id:133, pId: 37, name:"夹江县"},{id:134, pId: 37, name:"沐川县"},{id:135, pId: 37, name:"峨边彝族自治县"},{id:136, pId: 37, name:"马边彝族自治县"},{id:137, pId: 37, name:"峨眉山市"},{id:38, pId: 9, name:"南充市"},{id:138, pId: 38, name:"市辖区"},{id:139, pId: 38, name:"顺庆区"},{id:140, pId: 38, name:"高坪区"},{id:141, pId: 38, name:"嘉陵区"},{id:142, pId: 38, name:"南部县"},{id:143, pId: 38, name:"营山县"},{id:144, pId: 38, name:"蓬安县"},{id:145, pId: 38, name:"仪陇县"},{id:146, pId: 38, name:"西充县"},{id:147, pId: 38, name:"阆中市"},{id:39, pId: 9, name:"眉山市"},{id:148, pId: 39, name:"市辖区"},{id:149, pId: 39, name:"东坡区"},{id:150, pId: 39, name:"仁寿县"},{id:151, pId: 39, name:"彭山县"},{id:152, pId: 39, name:"洪雅县"},{id:153, pId: 39, name:"丹棱县"},{id:154, pId: 39, name:"青神县"},{id:40, pId: 9, name:"宜宾市"},{id:155, pId: 40, name:"市辖区"},{id:156, pId: 40, name:"翠屏区"},{id:157, pId: 40, name:"宜宾县"},{id:158, pId: 40, name:"南溪县"},{id:159, pId: 40, name:"江安县"},{id:160, pId: 40, name:"长宁县"},{id:161, pId: 40, name:"高　县"},{id:162, pId: 40, name:"珙　县"},{id:163, pId: 40, name:"筠连县"},{id:164, pId: 40, name:"兴文县"},{id:165, pId: 40, name:"屏山县"},{id:41, pId: 9, name:"广安市"},{id:166, pId: 41, name:"市辖区"},{id:167, pId: 41, name:"广安区"},{id:168, pId: 41, name:"岳池县"},{id:169, pId: 41, name:"武胜县"},{id:170, pId: 41, name:"邻水县"},{id:171, pId: 41, name:"华莹市"},{id:42, pId: 9, name:"达州市"},{id:172, pId: 42, name:"市辖区"},{id:173, pId: 42, name:"通川区"},{id:174, pId: 42, name:"达　县"},{id:175, pId: 42, name:"宣汉县"},{id:176, pId: 42, name:"开江县"},{id:177, pId: 42, name:"大竹县"},{id:178, pId: 42, name:"渠　县"},{id:179, pId: 42, name:"万源市"},{id:43, pId: 9, name:"雅安市"},{id:180, pId: 43, name:"市辖区"},{id:181, pId: 43, name:"雨城区"},{id:182, pId: 43, name:"名山县"},{id:183, pId: 43, name:"荥经县"},{id:184, pId: 43, name:"汉源县"},{id:185, pId: 43, name:"石棉县"},{id:186, pId: 43, name:"天全县"},{id:187, pId: 43, name:"芦山县"},{id:188, pId: 43, name:"宝兴县"},{id:44, pId: 9, name:"巴中市"},{id:189, pId: 44, name:"市辖区"},{id:190, pId: 44, name:"巴州区"},{id:191, pId: 44, name:"通江县"},{id:192, pId: 44, name:"南江县"},{id:193, pId: 44, name:"平昌县"},{id:45, pId: 9, name:"资阳市"},{id:194, pId: 45, name:"市辖区"},{id:195, pId: 45, name:"雁江区"},{id:196, pId: 45, name:"安岳县"},{id:197, pId: 45, name:"乐至县"},{id:198, pId: 45, name:"简阳市"},{id:47, pId: 9, name:"甘孜藏族自治州"},{id:199, pId: 46, name:"汶川县"},{id:200, pId: 46, name:"理　县"},{id:201, pId: 46, name:"茂　县"},{id:202, pId: 46, name:"松潘县"},{id:203, pId: 46, name:"九寨沟县"},{id:204, pId: 46, name:"金川县"},{id:205, pId: 46, name:"小金县"},{id:206, pId: 46, name:"黑水县"},{id:207, pId: 46, name:"马尔康县"},{id:208, pId: 46, name:"壤塘县"},{id:209, pId: 46, name:"阿坝县"},{id:210, pId: 46, name:"若尔盖县"},{id:211, pId: 46, name:"红原县"},{id:29, pId: 9, name:"绵阳市"},{id:96, pId: 29, name:"市辖区"},{id:97, pId: 29, name:"涪城区"},{id:98, pId: 29, name:"游仙区"},{id:99, pId: 29, name:"三台县"},{id:100, pId: 29, name:"盐亭县"},{id:101, pId: 29, name:"安　县"},{id:102, pId: 29, name:"梓潼县"},{id:103, pId: 29, name:"北川羌族自治县"},{id:104, pId: 29, name:"平武县"},{id:105, pId: 29, name:"江油市"},{id:34, pId: 9, name:"广元市"},{id:106, pId: 34, name:"市辖区"},{id:107, pId: 34, name:"市中区"},{id:108, pId: 34, name:"元坝区"},{id:109, pId: 34, name:"朝天区"},{id:110, pId: 34, name:"旺苍县"},{id:111, pId: 34, name:"青川县"},{id:112, pId: 34, name:"剑阁县"},{id:113, pId: 34, name:"苍溪县"},{id:35, pId: 9, name:"遂宁市"},{id:46, pId: 9, name:"阿坝藏族羌族自治州"},{id:114, pId: 35, name:"市辖区"},{id:115, pId: 35, name:"船山区"},{id:116, pId: 35, name:"安居区"},{id:117, pId: 35, name:"蓬溪县"},{id:118, pId: 35, name:"射洪县"},{id:119, pId: 35, name:"大英县"},{id:48, pId: 9, name:"凉山彝族自治州"},{id:212, pId: 47, name:"康定县"},{id:213, pId: 47, name:"泸定县"},{id:214, pId: 47, name:"丹巴县"},{id:215, pId: 47, name:"九龙县"},{id:216, pId: 47, name:"雅江县"},{id:217, pId: 47, name:"道孚县"},{id:218, pId: 47, name:"炉霍县"},{id:219, pId: 47, name:"甘孜县"},{id:220, pId: 47, name:"新龙县"},{id:221, pId: 47, name:"德格县"},{id:222, pId: 47, name:"白玉县"},{id:223, pId: 47, name:"石渠县"},{id:224, pId: 47, name:"色达县"},{id:225, pId: 47, name:"理塘县"},{id:226, pId: 47, name:"巴塘县"},{id:227, pId: 47, name:"乡城县"},{id:228, pId: 47, name:"稻城县"},{id:229, pId: 47, name:"得荣县"},{id:230, pId: 48, name:"西昌市"},{id:231, pId: 48, name:"木里藏族自治县"},{id:232, pId: 48, name:"盐源县"},{id:233, pId: 48, name:"德昌县"},{id:234, pId: 48, name:"会理县"},{id:235, pId: 48, name:"会东县"},{id:236, pId: 48, name:"宁南县"},{id:237, pId: 48, name:"普格县"},{id:238, pId: 48, name:"布拖县"},{id:239, pId: 48, name:"金阳县"},{id:240, pId: 48, name:"昭觉县"},{id:241, pId: 48, name:"喜德县"},{id:242, pId: 48, name:"冕宁县"},{id:243, pId: 48, name:"越西县"},{id:244, pId: 48, name:"甘洛县"},{id:245, pId: 48, name:"美姑县"},{id:246, pId: 48, name:"雷波县"}
];
$.fn.myselect = function(myonClick){
    if(this.hasClass("myselectstyle")){
        let inputID = this.attr("id");
        let inputValue = this.attr("value");
        this.hide();

        let comboboxString = '<input type="text" class="form-control" readonly="true" id="'+inputID+'_label" value="选择城市"><button type="button" class="btn btn-default" onClick="$(\'#'+inputID+'_tree_div\').toggle();" style="margin-top: 1px;"><span class="caret"></span></button><div id="'+inputID+'_tree_div" class="dropdown-menu" style="top:auto; left:auto; display:none; position: absolute;width: 338px; z-index: 9999;"><div onClick="$(\'#'+inputID+'_tree_div\').hide();" style="padding-right:5px;"><button type="button" class="close" aria-hidden="true">&times;</button></div><ul id="'+inputID+'_tree_show" class="ztree" style="margin-top:0; width:160px;"></ul></div>';
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