<%-- 
    Document   : Conectado_Desconectado
    Created on : 04-dic-2017, 11:52:22
    Author     : User
--%>
<%@page import="tree.Node"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="tree.TreeDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="shortcut icon" href="favicon.ico" />

        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/file-explore.css" rel="stylesheet" type="text/css">
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/tabsVertical.css" rel="stylesheet" type="text/css">
        <link href="css/w3.css" rel="stylesheet" type="text/css"/>
        <link href="css/DefauldStyles.css" rel="stylesheet" type="text/css"/>
        <link href="css/MobileStyles.css" rel="stylesheet" type="text/css"/>

        <!-- script -->
        <script src="js/jquery/jquery.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/bootstrap-treeview-1.2.0/dist/bootstrap-treeview.min.js"></script>
        <script src="js/Tab.js" type="text/javascript"></script>
        <script src="js/file-explore.js" type="text/javascript"></script>

        <title>Página Principal</title>
    </head>

    <body>
        <%
            TreeDB tree = new TreeDB();
            tree.buildTree();
        %>
        <div class="w3-container">
            <nav class="navbar navbar-fixed-top">
                <ul class="nav">
                    <li>
                        <button id="hamburguesa" class="w3-button w3-teal w3-xlarge w3-hide-large pull-left" onclick="hamburguesa()">
                            <li><span class="glyphicon glyphicon-menu-hamburger "></span></li>
                        </button>
                        <button  id="casa" name="data" class="w3-button w3-teal w3-xlarge pull-left"  type="button" onclick="getHome()">
                            <span class="glyphicon glyphicon-home">   
                            </span>
                        </button>
                    </li>
                    <li>
                        <div class="btn-group pull-right">
                            <button class="w3-button w3-teal w3-xlarge dropdown-toggle pull-right" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user"></span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li class="dropdown-item"><a id="username"></a></li>
                                <li class="dropdown-item"><a href="index.jsp"  onclick="signOut()">Sign Out  <span class="glyphicon glyphicon-log-out ">
                                </span></a></li>
                                <meta name="google-signin-client_id" 
                                      content="215508450936-s45rubl83k8amm91p1qv0tbvmjrq6kkr.apps.googleusercontent.com">
                                <script>

                                    function signOut() {
                                        var auth2 = gapi.auth2.getAuthInstance();
                                        auth2.signOut().then(function () {
                                            deleteCookie("username");
                                            console.log('User signed out.');
                                        });

                                    }
                                    function onLoad() {
                                        gapi.load('auth2', function () {
                                            gapi.auth2.init();
                                            var username = getCookie("username");
                                            if (username != null) {
                                                document.getElementById("username").innerHTML = username;
                                            } else {

                                            }
                                        });
                                    }

                                    function getCookie(name) {
                                        var value = "; " + document.cookie;
                                        var parts = value.split("; " + name + "=");
                                        if (parts.length == 2)
                                            return parts.pop().split(";").shift();
                                    }

                                    function deleteCookie(name) {
                                        document.cookie = name + '=;expires=Thu, 01 Jan 1970 00:00:01 GMT;';
                                    }
                                </script>
                                <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
                            </ul>
                        </div>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="content2">
            <div class="w3-sidebar w3-bar-block w3-collapse w3-card w3-animate-left" id="mySidebar" onsubmit="return false">
                <div id="tree1" class="tree sm-mb" ></div>
                <ul id="tab-list" class="nav nav-pills tabs-left" role="tablist">
                    <li class="tabclass active" id="hometab"><a href="#home" role="tab" data-toggle="tab">Home</a></li>
                </ul>
            </div>
            <div class="tab-content contenido">
                <div class="tab-pane active" id="home">
                    <div id="tree2" class="tree sxl-mb" >
                    </div>
                </div>
            </div>
        </div>
        <script>
            function hamburguesa() {
                $("#mySidebar").toggle();
            }
            function getHome() {
                $(".tabclass.active").removeClass('active');
                $(".tab-pane.active").removeClass('active');
                document.getElementById("home").className = "tab-pane active";
            }
        </script>
        <script>
            //data to create the menu in treeview
            function getTree() {
                //data from db 
                var data = <%= TreeDB.getTreeString()%>;
                return data;
            }
            var tabID = 0;  //tab id
            createTree('#tree1');
            createTree('#tree2');
            //create the menu
            function createTree(treeID) {
                $(treeID).treeview({
                    data: getTree(),
                    enableLinks: true,
                    levels: 1,
                    showTags: true,
                    color: 'black',
                    backColor: '#F0F0F0'
                });
                //on node selected
                /**/ $(treeID).on('nodeSelected', function (e, node) {
                    if (typeof node['nodes'] == "undefined") {

                        //new tab
                        tabID = node.text.replace(/\s/g, "_");
                        if (document.getElementById(tabID) === null) {
                            $('#tab-list').append($('<li class="tabclass"><a href="#' + tabID + '" role="tab" data-toggle="tab">' + node.text + '&nbsp' + '&nbsp' + '&nbsp' + '<button class="close" type="button" title="Remove this page">×</button></a></li>'));

                            //Content panel of the new tab
                            $('<div class="tab-pane" id="' + tabID + '">' + node.text + '</div>').appendTo('.tab-content');
                            //display new tab
                            $('#home').tab('show');
                            $('#tab-pane a:last').tab('show');
                            //close tabs
                            $('#tab-list').on('click', '.close', function () {
                                tabID = $(this).parents('a').attr('href');
                                tabID = null;
                                $("#" + tabID).remove();
                                $(this).parents('li').remove();
                                $(tabID).remove();
                                //show the previous tab opened
                                var tabLast = $('#tab-list a:last');
                                tabLast.tab('show');
                            });
                        }
                    }
                    $(treeID).treeview('toggleNodeExpanded', [node.nodeId, {silent: true}]);
                    $(treeID).treeview('unselectNode', [node.nodeId, {silent: true}]);
                });
            }
        </script>
        <script>
            $(document).ready(function () {
                $(".file-tree").filetree();
            });
        </script>
        <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-36251023-1']);
            _gaq.push(['_setDomainName', 'jqueryscript.net']);
            _gaq.push(['_trackPageview']);
            (function () {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();

        </script>
    </body>
</html>