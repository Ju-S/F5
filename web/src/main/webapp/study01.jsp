<%--
  Created by IntelliJ IDEA.
  User: keduit
  Date: 25. 8. 28.
  Time: 오후 5:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/common/Head.jsp"/>

    <title>Title</title>

    <style>
        #container1 {
            margin: auto;
            width: 500px;
            height: 500px;
            border: 1px solid black;
        }

        .btn.btn-primary {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            padding: 0;
            font-size: 14px;
        }

        .card.card-body {
            display: inline-block;
            width: 50px;
            height: 200px;
            border: 1px solid red;
        }

        p {
            margin: 0;
            padding: 0;
        }
        .accordion-item {
            border: none !important;
            box-shadow: none !important;
            margin-bottom: 20px;
        }
        #pt1{
            position: absolute;

        }
        #collapseExample2{
            background-color: #949494;
            position:absolute;
        }
        #pt2{
            position: absolute;

        }
        #pt3{
            position: absolute;

        }

    </style>


</head>
<body>

<div id="container1">

    <div class="accordion" id="accordionToggleGroup">

        <!-- 토글 1번 -->
        <div class="accordion-item" id="pt1">
            <p>
                <button class="btn btn-primary" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseExample1" aria-expanded="false"
                        aria-controls="collapseExample1">
                    1번
                </button>
            </p>

            <div class="collapse" id="collapseExample1" data-bs-parent="#accordionToggleGroup">
                <div class="card card-body" id="ch1">
                    1번 토글
                </div>
            </div>


        </div>

        <!-- 토글 2번 -->
        <div class="accordion-item" id="pt2">
            <p>
                <button class="btn btn-primary" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseExample2" aria-expanded="false"
                        aria-controls="collapseExample2">
                    2번
                </button>
            </p>
            <div class="collapse" id="collapseExample2" data-bs-parent="#accordionToggleGroup">
                <div class="card card-body">
                    2번 토글
                </div>
            </div>
        </div>

        <!-- 토글 3번 -->
        <div class="accordion-item" id="pt3">
            <p>
                <button class="btn btn-primary" type="button" data-bs-toggle="collapse"
                        data-bs-target="#collapseExample3" aria-expanded="false"
                        aria-controls="collapseExample3">
                    3번
                </button>
            </p>
            <div class="collapse" id="collapseExample3" data-bs-parent="#accordionToggleGroup">
                <div class="card card-body">
                    3번 토글
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
