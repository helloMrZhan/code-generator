package ${package}.${moduleName}.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${package}.${moduleName}.convert.${ClassName}Convert;
import ${package}.${moduleName}.entity.${ClassName}Entity;
import ${package}.${moduleName}.query.${ClassName}Query;
import ${package}.${moduleName}.vo.${ClassName}VO;
import ${package}.${moduleName}.mapper.${ClassName}Mapper;
import ${package}.${moduleName}.service.${ClassName}Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.BeanUtils;

import java.util.List;

/**
 * ${tableComment}
 *
 * @author ${author} ${email}
 * @since ${version} ${date}
 */
@Service
@AllArgsConstructor
public class ${ClassName}ServiceImpl extends ServiceImpl<${ClassName}Mapper, ${ClassName}Entity> implements ${ClassName}Service {

    @Override
    public Page<${ClassName}VO> page(${ClassName}Query param) {
        Page<${ClassName}VO> page = new Page<>(param.getPage(), param.getLimit());
        LambdaQueryWrapper<${ClassName}Entity> queryWrapper = getPageQueryWrapper(param);
        PageInfo<${ClassName}VO> selectPage = PageHelper.startPage(param.getPage(), param.getLimit())
                .doSelectPageInfo(() -> baseMapper.queryPageList(queryWrapper));
        page.setRecords(selectPage.getList());
        page.setTotal(selectPage.getTotal());
        return page;
    }

    private LambdaQueryWrapper<${ClassName}Entity> getPageQueryWrapper(${ClassName}Query query){
        LambdaQueryWrapper<${ClassName}Entity> wrapper = Wrappers.lambdaQuery();
        <#list queryList as field>
            <#if field.queryFormType == 'date' || field.queryFormType == 'datetime'>
        wrapper.between(ArrayUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, ArrayUtils.isNotEmpty(query.get${field.attrName?cap_first}()) ? query.get${field.attrName?cap_first}()[0] : null, ArrayUtils.isNotEmpty(query.get${field.attrName?cap_first}()) ? query.get${field.attrName?cap_first}()[1] : null);
            <#elseif field.queryType == '='>
        wrapper.eq(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == '!='>
        wrapper.ne(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == '>'>
        wrapper.gt(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == '>='>
        wrapper.ge(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == '<'>
        wrapper.lt(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == '<='>
        wrapper.le(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == 'like'>
        wrapper.like(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == 'left like'>
        wrapper.likeLeft(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            <#elseif field.queryType == 'right like'>
        wrapper.likeRight(StringUtils.isNotEmpty(query.get${field.attrName?cap_first}()), ${ClassName}Entity::get${field.attrName?cap_first}, query.get${field.attrName?cap_first}());
            </#if>
        </#list>
        return wrapper;
    }

    @Override
    public void save(${ClassName}VO vo) {
        ${ClassName}Entity entity = new ${ClassName}Entity();
        BeanUtils.copyProperties(vo, entity);
        baseMapper.insert(entity);
    }

    @Override
    public void update(${ClassName}VO vo) {
        ${ClassName}Entity entity = ${ClassName}Convert.INSTANCE.convert(vo);

        updateById(entity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<Long> idList) {
        removeByIds(idList);
    }

}