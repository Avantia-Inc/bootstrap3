<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="lang" uri="http://jahia.com/tags/languageswitcher" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="css" resources="bootstrap.min.css"/>
<template:addResources type="javascript" resources="jquery.min.js,bootstrap.min.js"/>

<c:set var="size"/>
<c:if test="${jcr:isNodeType(currentNode, 'bootstrap3mix:advancedModal')}">
    <c:set var="size" value="modal-${currentNode.properties.size.string}"/>
</c:if>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal${currentNode.name}">
    ${currentNode.properties.openText.string}
</button>

<!-- Modal -->
<div class="<c:if test='${!renderContext.editMode}'>modal fade</c:if>" id="myModal${currentNode.name}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel${currentNode.name}" aria-hidden="${renderContext.editMode ? 'false' : 'true'}">
    <div class="modal-dialog ${size}"<c:if test='${renderContext.editMode}'> style="margin:5px;"</c:if>>
        <div class="modal-content">
            <c:if test="${! empty title}">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel${currentNode.name}">${title}</h4>
                </div>
            </c:if>
            <div class="modal-body">
                <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jmix:droppableContent')}" var="droppableContent">
                    <template:module node="${droppableContent}" editable="true"/>
                </c:forEach>
                <c:if test="${renderContext.editMode}">
                    <template:module path="*" nodeTypes="jmix:droppableContent"/>
                </c:if>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">${currentNode.properties.closeText.string}</button>
            </div>
        </div>
    </div>
</div>

