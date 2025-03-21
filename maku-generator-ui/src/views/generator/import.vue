<template>
	<el-dialog v-model="visible" title="导入数据库表" :close-on-click-modal="false" draggable>
		<el-form ref="dataFormRef" :model="dataForm">
			<el-form-item label="数据源" prop="datasourceId">
				<el-select v-model="dataForm.datasourceId" style="width: 60%" placeholder="请选择数据源" @change="getTableList">
					<el-option label="默认数据源" value="0"></el-option>
					<el-option v-for="ds in dataForm.datasourceList" :key="ds.id" :label="ds.connName" :value="ds.id"> </el-option>
				</el-select>
				<!-- 表名搜索框 -->
				<el-input v-model="state.queryForm.tableName" style="width: 30%" placeholder="表名" clearable></el-input>
				<!-- 查询按钮 -->
				<el-button type="primary" style="width: 10%" @click="getDataList()">查询</el-button>
			</el-form-item>

			<el-table :data="dataForm.tableList" border style="width: 100%" :max-height="400" @selection-change="selectionChangeHandle">
				<el-table-column type="selection" header-align="center" align="center" width="60"></el-table-column>
				<el-table-column prop="tableName" label="表名" header-align="center" align="center"></el-table-column>
				<el-table-column prop="tableComment" label="表说明" header-align="center" align="center"></el-table-column>
			</el-table>
		</el-form>
		<template #footer>
			<el-button @click="visible = false">取消</el-button>
			<el-button type="primary" @click="submitHandle()">确定</el-button>
		</template>
	</el-dialog>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import { ElMessage } from 'element-plus/es'
import { useDataSourceListApi } from '@/api/datasource'
import { useTableImportSubmitApi } from '@/api/table'
import { useDataSourceTableListApi } from '@/api/datasource'
import { useDataSourceTableApi } from '@/api/datasource'
import { IHooksOptions } from '@/hooks/interface'
import { useCrud } from '@/hooks'

const emit = defineEmits(['refreshDataList'])

const visible = ref(false)
const dataFormRef = ref()

const dataForm = reactive({
	id: '',
	tableNameListSelections: [] as any,
	datasourceId: '',
	datasourceList: [] as any,
	tableList: [] as any,
	table: {
		tableName: ''
	}
})

const state: IHooksOptions = reactive({
	dataListUrl: '/gen/table/page',
	deleteUrl: '/gen/table',
	queryForm: {
		tableName: ''
	}
})

// 多选
const selectionChangeHandle = (selections: any[]) => {
	dataForm.tableNameListSelections = selections.map((item: any) => item['tableName'])
}

const init = () => {
	visible.value = true
	dataForm.id = ''

	// 重置表单数据
	if (dataFormRef.value) {
		dataFormRef.value.resetFields()
	}

	dataForm.tableList = []

	getDataSourceList()
}

const getDataSourceList = () => {
	useDataSourceListApi().then(res => {
		dataForm.datasourceList = res.data
	})
}

const getTableList = () => {
	dataForm.table.tableName = ''
	useDataSourceTableListApi(dataForm.datasourceId).then(res => {
		dataForm.tableList = res.data
	})
}

// 根据表名查询（支持空表名时查询全表）
const getDataList = () => {
	// 如果未选择数据源
	if (!dataForm.datasourceId) {
		ElMessage.warning('请先选择数据源')
		return
	}

	// 根据表名是否为空，决定调用哪个接口
	if (state.queryForm.tableName) {
		// 有表名时调用带表名的接口
		useDataSourceTableApi(dataForm.datasourceId, state.queryForm.tableName).then(res => {
			dataForm.tableList = res.data
		})
	} else {
		// 表名为空时调用全量接口
		useDataSourceTableListApi(dataForm.datasourceId).then(res => {
			dataForm.tableList = res.data
		})
	}
}

// 表单提交
const submitHandle = () => {
	const tableNameList = dataForm.tableNameListSelections ? dataForm.tableNameListSelections : []
	if (tableNameList.length === 0) {
		ElMessage.warning('请选择记录')
		return
	}

	useTableImportSubmitApi(dataForm.datasourceId, tableNameList).then(() => {
		ElMessage.success({
			message: '操作成功',
			duration: 500,
			onClose: () => {
				visible.value = false
				emit('refreshDataList')
			}
		})
	})
}

defineExpose({
	init
})
</script>
