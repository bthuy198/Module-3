﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Minton - Responsive Admin Dashboard Template</title>
    <jsp:include page="/WEB-INF/dashboard/layout/meta-head.jsp"></jsp:include>
</head>

<body>

<!-- Begin page -->
<div id="wrapper">
    <jsp:include page="/WEB-INF/dashboard/layout/top-bar.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/dashboard/layout/left-bar.jsp"></jsp:include>

    <div class="content-page">
        <div class="content">

            <!-- Start Content-->
            <div class="container-fluid">

                <!-- start page title -->
                <div class="row">
                    <div class="col-12">
                        <div class="page-title-box">
                            <div class="page-title-right">
                                <ol class="breadcrumb m-0">
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Minton</a></li>
                                    <li class="breadcrumb-item"><a href="javascript: void(0);">Forms</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>
                            </div>
                            <h4 class="page-title">Create new customer</h4>
                        </div>
                    </div>
                </div>
                <!-- end page title -->

                <div class="row">
                    <div class="col-12">
                        <div class="card-box">
                            <c:if test="${requestScope.message != null}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                  ${requestScope.message}
                                </div>
                            </c:if>
                            <c:if test="${requestScope.errors!=null && requestScope.errors.size()!=0}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <c:forEach var="error" items="${requestScope.errors}">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        <ul>
                                            <li>${error}</li>
                                        </ul>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <h4 class="header-title">Input customer's infomation</h4>

                            <div class="row">
                                <div class="col-12">
                                    <div class="p-2">
                                        <form class="form-horizontal" action="/customer?action=create"
                                              method="post" enctype="multipart/form-data">
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Name</label>
                                                <div class="col-sm-10">
                                                    <input type="text" id="name" class="form-control" name="name"
                                                           placeholder="Customer name"
                                                           value="${requestScope.customer.getName()}">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Birthday</label>
                                                <div class="col-sm-10">
                                                    <input type="date" id="birthday" class="form-control"
                                                           name="birthday" value="<fmt:formatDate pattern = "yyyy-MM-dd"
                                            value = "${requestScope.customer.getBirthday()}" />">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Image</label>
                                                <div class="col-sm-10">
                                                    <input type="file" class="form-control" id="image" name="image"
                                                           value="${requestScope.customer.getImg()}">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Address</label>
                                                <div class="col-sm-10">
                                                    <input type="text" class="form-control" id="address" name="address"
                                                           placeholder="Address"
                                                           value="${requestScope.customer.getAddress()}">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Type</label>
                                                <div class="col-sm-10">
                                                    <select class="form-select custom-select"
                                                            aria-label="Default select example" name="idType"
                                                            id="idType">
                                                        <c:forEach var="cType" items="${requestScope.customerTypes}">
                                                            <option value="${cType.getId()}"><c:out
                                                                    value="${cType.getType()}"></c:out></option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="offset-4">
                                                    <button type="submit" class="btn btn-primary"
                                                            style="padding: 10px 40px">Create
                                                    </button>
                                                    <button class="btn btn-primary"
                                                            style="padding: 10px 40px"><a href="/customer" style="text-decoration: none; color: white">Cancel</a>
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>
                            <!-- end row -->

                        </div> <!-- end card-box -->
                    </div><!-- end col -->
                </div>
                <!-- end row -->
            </div> <!-- container -->

        </div> <!-- content -->

        <!-- Footer Start -->
        <jsp:include page="/WEB-INF/dashboard/layout/footer.jsp"></jsp:include>
        <!-- end Footer -->

    </div>

</div>
<!-- END wrapper -->

<!-- Vendor js -->
<script src="/dashboard/assets\js\vendor.min.js"></script>
<!-- Tost-->
<script src="/dashboard/assets\libs\jquery-toast\jquery.toast.min.js"></script>

<!-- toastr init js-->
<script src="/dashboard/assets\js\pages\toastr.init.js"></script>

<!-- App js -->
<script src="/dashboard/assets\js\app.min.js"></script>

</body>
</html>