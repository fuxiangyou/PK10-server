<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--[if lt IE 9]>
<script src="http://libs.baidu.com/jquery/1.11.1/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<script src="${pageContext.request.contextPath}/assets/js/amazeui.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.page.js"></script>

<html class="no-js">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="keywords" content="table">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <title>充值记录列表</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/i/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/assets/i/app-icon72x72@2x.png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/amazeui.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/app.css">

    <style type="text/css">
        body {
            overflow-x: hidden;
            overflow-y: scroll;
        }

        ul li a span {
            padding-top: 11px;
        }
    </style>
</head>

<body>

    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">代理商功能/充值记录</strong> </div>
    </div>
    <hr>
    <div class="am-u-md-4">
        <input type="text" id="start_time" value="${startTime}" class="am-form-field" placeholder="开始时间" data-am-datepicker readonly required />
    </div>
    <div class="am-u-md-4">
        <input type="text" id="end_time" value="${endTime}" class="am-form-field" placeholder="结束时间" data-am-datepicker readonly required />
    </div>
    <div class="am-u-md-4"><button class="am-btn am-btn-primary" onclick="mar_search()">搜索</button>
    </div>

<div class="am-g">
    <div class="am-u-sm-12">
        <table class="am-table am-table-striped am-table-hover table-main">
            <thead>
            <tr>
                <%--<th class="table-check">
                    <input type="checkbox" />
                </th>--%>
                <th>充值用户</th>
                <th>代理商用户名</th>
                <th>充值金额</th>
                <th>充值时间</th>
            </tr>
            </thead>
            <tbody id="users">
            <c:choose>
                <c:when test="${requestScope.records == null}">
                    ${errorMsg}
                </c:when>
                <c:otherwise>
                    <c:forEach items="${records}" var="record" varStatus="vs">
                        <tr>
                            <td>${record.userName}</td>
                            <td>${record.addAgentName}</td>
                            <td class="am-hide-sm-only">${record.addMoney}</td>
                            <td class="am-hide-sm-only">
                                <f:formatDate value="${record.addTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </td>
                        </tr>

                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <div>
            <div class="am-al">共 ${page.total} 条记录</div>
            <div class="tcdPageCode">

                <script>
                    var s_time = '${startTime}';
                    var e_time = '${endTime}';
                    $(".tcdPageCode").createPage({
                        pageCount:${page.pages},
                        current:${pn},
                        backFn:function(p){
                            location.href = '<%=request.getContextPath()%>/money-add-record/' + s_time +'/'+ e_time +
                                    "?curAgentId=${sessionScope.userinfo.id}&pn=" + p;
                        }
                    });

                </script>

            </div>
        </div>
    </div>
</div>
<!-- content end -->
<!-- recharge -->
<div class="am-modal am-modal-alert" tabindex="-1" id="recharge">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">充值记录</div>
        <div class="am-modal-bd">
            <table class="am-table am-table-striped am-table-hover table-main">
                <thead>
                <tr>
                    <th>代理商ID</th>
                    <th>代理商用户名</th>
                    <th>充值金额</th>
                    <th>充值时间</th>
                </tr>
                </thead>
                <tbody id="recharge_record">
                </tbody>
            </table>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" id="btn-ok">确定</span>
        </div>
    </div>
</div>

<footer class="admin-content-footer">
    <hr>
    <p class="am-padding-left">© 中远方舟科技有限公司版权所有</p>
</footer>

<script type="text/javascript">
    function mar_search() {

        var s_time = $("#start_time").val();
        var e_time = $("#end_time").val();
        console.log("mar_search : s_time ==> " + s_time + "\te_time ==> "+ e_time);
        if (s_time > e_time) {
            alert('请选择正确的时间区间');
        } else if (s_time == "" && e_time == ""){
            window.location.reload();
        } else if (s_time != "" && e_time == "" || s_time == "" && e_time != "") {
            alert('请选择正确的时间区间');
        } else {
            location.href = '<%=request.getContextPath()%>/money-add-record/' + s_time +'/'+ e_time +
                    "?curAgentId=${sessionScope.userinfo.id}&pn=1";
        }
    }

    function set_time() {
        console.log("set_time: s_time <== ${startTime} \te_time <== ${endTime}");
        $("#start_time").val('${startTime}');
        $("#end_time").val('${endTime}');
    }

</script>
</body>

</html>
