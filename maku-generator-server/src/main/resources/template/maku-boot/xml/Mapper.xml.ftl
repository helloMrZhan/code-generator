<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${package}.${moduleName}.mapper.${ClassName}Mapper">

    <resultMap type="${package}.${moduleName}.entity.${ClassName}Entity" id="${className}Map">
        <#list fieldList as field>
        <result property="${field.attrName}" column="${field.fieldName}"/>
        </#list>
    </resultMap>

    <select id="queryPageList" resultType="${package}.${moduleName}.entity.${ClassName}Entity">
        SELECT
        w.*
        FROM
        ${tableName} w
        <#noparse>${ew.customSqlSegment}</#noparse>
    </select>

</mapper>