package ${package}.${moduleName}.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import ${package}.${moduleName}.vo.${ClassName}VO;
import ${package}.${moduleName}.query.${ClassName}Query;
import ${package}.${moduleName}.entity.${ClassName}Entity;

import java.util.List;

/**
 * ${tableComment}
 *
 * @author ${author} ${email}
 * @since ${version} ${date}
 */
public interface ${ClassName}Service extends IService<${ClassName}Entity> {

    Page<${ClassName}VO> page(${ClassName}Query query);

    void save(${ClassName}VO vo);

    void update(${ClassName}VO vo);

    void delete(List<Long> idList);
}