package ${package}.${moduleName}.query;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import com.dataqin.common.core.domain.param.BasePageCommon;
import org.springframework.format.annotation.DateTimeFormat;

<#list importList as i>
import ${i!};
</#list>

/**
* ${tableComment}查询
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Data
@EqualsAndHashCode(callSuper = false)
@ApiModel(value = "${ClassName}Query", description = "${tableComment}查询")
public class ${ClassName}Query extends BasePageCommon {
<#list queryList as field>
    <#if field.fieldComment!?length gt 0>
    @Schema(description = "${field.fieldComment}")
    </#if>
    <#if field.queryFormType == 'date'>
    @DateTimeFormat(pattern="yyyy-MM-dd")
    <#elseif field.queryFormType == 'datetime'>
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    </#if>
    private ${field.attrType}<#if field.queryFormType == 'date' || field.queryFormType == 'datetime'>[]</#if> ${field.attrName};

</#list>
}