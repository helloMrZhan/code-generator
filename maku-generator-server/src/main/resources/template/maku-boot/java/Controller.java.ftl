package ${package}.${moduleName}.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dataqin.common.core.domain.CommonResult;
import ${package}.${moduleName}.convert.${ClassName}Convert;
import ${package}.${moduleName}.entity.${ClassName}Entity;
import ${package}.${moduleName}.service.${ClassName}Service;
import ${package}.${moduleName}.query.${ClassName}Query;
import ${package}.${moduleName}.vo.${ClassName}VO;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
* ${tableComment}
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@RestController
@RequestMapping("${moduleName}/${functionName}")
@Api(tags = "${tableComment}")
@AllArgsConstructor
public class ${ClassName}Controller {
    private final ${ClassName}Service ${className}Service;

    @GetMapping("page")
    @ApiOperation("分页")
    //@PreAuthorize("hasAuthority('${moduleName}:${functionName}:page')")
    public CommonResult<Page<${ClassName}VO>> page(@Valid ${ClassName}Query query){
        Page<${ClassName}VO> page = ${className}Service.page(query);

        return CommonResult.success(page);
    }

    @GetMapping("{id}")
    @ApiOperation("详情信息")
    //@PreAuthorize("hasAuthority('${moduleName}:${functionName}:info')")
    public CommonResult<${ClassName}VO> get(@PathVariable("id") Long id){
        ${ClassName}Entity entity = ${className}Service.getById(id);

        return CommonResult.success(${ClassName}Convert.INSTANCE.convert(entity));
    }

    @PostMapping
    @ApiOperation("保存")
    //@PreAuthorize("hasAuthority('${moduleName}:${functionName}:save')")
    public CommonResult<String> save(@RequestBody ${ClassName}VO vo){
        ${className}Service.save(vo);

        return CommonResult.success();
    }

    @PutMapping
    @ApiOperation("修改")
    //@PreAuthorize("hasAuthority('${moduleName}:${functionName}:update')")
    public CommonResult<String> update(@RequestBody @Valid ${ClassName}VO vo){
        ${className}Service.update(vo);

        return CommonResult.success();
    }

    @DeleteMapping
    @ApiOperation("删除")
    //@PreAuthorize("hasAuthority('${moduleName}:${functionName}:delete')")
    public CommonResult<String> delete(@RequestBody List<Long> idList){
        ${className}Service.delete(idList);

        return CommonResult.success();
    }
}