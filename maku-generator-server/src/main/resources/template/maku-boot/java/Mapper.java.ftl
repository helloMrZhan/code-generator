package ${package}.${moduleName}.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import ${package}.${moduleName}.entity.${ClassName}Entity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

/**
* ${tableComment}
*
* @author ${author} ${email}
* @since ${version} ${date}
*/
@Mapper
public interface ${ClassName}Mapper extends BaseMapper<${ClassName}Entity> {

    /**
    * 分页查询
    *
    * @param queryWrapper
    */
    List<${ClassName}Entity> queryPageList(@Param(Constants.WRAPPER) LambdaQueryWrapper<${ClassName}Entity> queryWrapper);
}