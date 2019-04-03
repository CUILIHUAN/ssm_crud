<%--
  Created by IntelliJ IDEA.
  User: cui
  Date: 2019/4/1
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <title>Title</title>
    <script src="${APP_PATH}/js/jquery-1.9.1.min.js" type="text/javascript"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>

<!-- 员工添加模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>


    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_model_btn">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--显示表格的数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>

                </table>
            </div>
        </div>
        <%--显示分面信息--%>
        <div class="row">
            <%--分页文字显示--%>
            <div class="col-md-6" id="page_info_area"></div>
            <%--分布显示 --%>
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                //去首页
                to_page(1);
            });

            function to_page(pn) {
                //页面加载完成以后，直接发送ajax请求，要到分页数据
                $(function () {
                    $.ajax({
                        url: "${APP_PATH}/emp",
                        data: "pn=" + pn,
                        type: "GET",
                        success: function (result) {
                            console.log(result);
                            //1.解析并显示员工数量
                            build_emps_table(result);
                            //2.解析并显示分页信息
                            build_page_info(result);
                            //3.显示分页条信息
                            build_page_nav(result);
                        }
                    })

                });
            }

            function build_emps_table(result) {
                $("#emps_table tbody").empty();
                var emps = result.extend.pageInfo.list;
                $.each(emps, function (index, item) {
                    var empIdTd = $("<td></td>").append(item.empid);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameId = $("<td><td>").append(item.department.deptName);

                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));

                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                    $("<tr></tr>").append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameId)
                        .append(btnTd)
                        .appendTo("#emps_table tbody");


                })
            }

            //显示分布信息
            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "为页,总共"
                    + result.extend.pageInfo.pages + "页,总" +
                    result.extend.pageInfo.total + "条记录");
            }

            function build_page_nav(result) {

                $("#page_nav_area").empty();

                var ul = $("<ul></ul>").addClass("pagination");


                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
                if (result.extend.pageInfo.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                } else {
                    //为元素填加翻页事件
                    firstPageLi.click(function () {
                        to_page(1);
                    });
                    prePageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum - 1);
                    });
                }

                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
                if (result.extend.pageInfo.hasNextPage == false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                } else {
                    nextPageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum + 1);
                    });
                    lastPageLi.click(function () {
                        to_page(result.extend.pageInfo.pages);
                    });
                }


                ul.append(firstPageLi).append(prePageLi);

                $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {

                    var numLi = $("<li></li>").append($("<a></a>").append(item));
                    if (result.extend.pageInfo.pageNum == item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_page(item);
                    });
                    ul.append(numLi);
                });
                ul.append(nextPageLi);
                ul.append(lastPageLi);

                var navEle = $("<nav></nav>").append(ul);
                navEle.appendTo("#page_nav_area");
            }

            $("#emp_add_model_btn").click(function () {
                $("#myModal").modal({
                    backdrop: "static"
                });

            });

        </script>

    </div>
</body>
</html>
