package ${package}.${moduleName}.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.io.Serializable;
import ${package}.framework.common.utils.DateUtils;
<#list importList as i>
import ${i!};
</#list>

/**
* ${tableComment}
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Data
@ApiModel("${tableComment}响应对象")
public class ${ClassName}VO implements Serializable {
	private static final long serialVersionUID = 1L;

<#list fieldList as field>
	<#if field.fieldComment!?length gt 0>
	@ApiModelProperty(value = "${field.fieldComment}")
	</#if>
	<#if field.attrType == 'Date'>
	@JsonFormat(pattern = DateUtils.DATE_TIME_PATTERN)
	</#if>
	<#if field.attrType == 'Long'>
	@JsonFormat(shape = JsonFormat.Shape.STRING)
	</#if>
	private ${field.attrType} ${field.attrName};

</#list>

}