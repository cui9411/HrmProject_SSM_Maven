<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2019/6/24
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加公告</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/easyui/1.3.3/locale/easyui-lang-zh_CN.js"></script>
</head>
<body style="margin:1px;" id="ff" >
<div id="dl" class="easyui-layout" align="center">
    <form id="fm" method="post" class="easyui-form" >
        <table>
            <tr  align="center">
                <td><label>主题：</label>
                <input type="text" id="title" name="noticeTitle" class="easyui-validatebox" required="true" style="width: 200px"/></td>
                <td>
                    <label>邮件通知：</label>
                    <select class="easyui-combobox" panelHeight="auto" style="width:100px" id="emailNotice" name="noticePeople">
                        <option value="1">公司全体</option>
                        <option value="2">仅管理员</option>
                        <option value="0">否</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <textarea id="editor" name="noticeContent"></textarea>
                </td>
            </tr>
        </table>
    </form>
</div>

<div id="dlg-buttons" align="center">
    <a href="javascript:saveArt()" class="easyui-linkbutton" iconCls="icon-ok" id="save">发布</a> <a href="javascript:reset()" class="easyui-linkbutton" iconCls="icon-cancel">清空</a>
</div>


<script type="text/javascript">
    function reset() {
        $('#editor').val("");
        $('#title').val("");
        keditor.html("");
    }

    //采用jquery easyui loading css效果
    function ajaxLoading(){
        $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");
        $("<div class=\"datagrid-mask-msg\"></div>").html("正在发布，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
    }
    function ajaxLoadEnd(){
        $(".datagrid-mask").remove();
        $(".datagrid-mask-msg").remove();
    }



    function saveArt() {
        $("#fm").form("submit", {
            url: '${pageContext.request.contextPath}/notice/add.action',
            onSubmit: function () {
                return $(this).form("validate");
            },
            beforeSend:ajaxLoading(),
            success: function (result) {
                ajaxLoadEnd();
                if (result == "ok") {
                    $.messager.alert("系统提示", "公告发布成功");
                    reset();
                }else {
                    $.messager.alert("系统提示","公告发布失败");
                }
                //resetValue();
            }
        });
    }

    var keditor;

    function kedit(keid){

        //alert(1);

        keditor =  KindEditor.create(

            '#' + keid,

            {

                width : "100%", //编辑器的宽度为

                height : "480px", //编辑器的高度为100px

                filterMode : false, //不会过滤HTML代码

                resizeMode : 1 ,//编辑器只能调整高度

                uploadJson : '${pageContext.request.contextPath}/kindeditor-4.1.10/jsp/upload_json.jsp',

                fileManagerJson : '${pageContext.request.contextPath}/kindeditor-4.1.10/jsp/file_manager_json.jsp',

                allowImageUpload:true,

                allowUpload : true,

                allowFileManager : true,

                afterCreate : function() {

                    var self = this;

                    KindEditor.ctrl(document, 13, function() {

                        self.sync();

                        document.forms['example'].submit();

                    });

                    KindEditor.ctrl(self.edit.doc, 13, function() {

                        self.sync();

                        document.forms['example'].submit();

                    });

                },

                items : [

                    'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'code', 'cut', 'copy', 'paste',

                    'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',

                    'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',

                    'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',

                    'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',

                    'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|',

                    'table', 'hr', 'pagebreak',

                    'anchor', 'link', 'unlink', '|', 'image','multiimage','flash','media','insertfile','editImage'

                ],

                afterBlur: function(){this.sync();},//和DWZ 的 Ajax onsubmit 冲突,提交表单时 编辑器失去焦点执行填充内容

                newlineTag : "br"

            });
        //alert(1);
    }
    $(function (){
        //alert(1);
        kedit("editor");
    });
</script>
</body>
</html>
