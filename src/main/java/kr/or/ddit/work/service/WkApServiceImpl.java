package kr.or.ddit.work.service;

import java.io.FileOutputStream;
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.approval.vo.ApboxVO;
import kr.or.ddit.approval.vo.DocWriVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.mapper.WorkMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WkApServiceImpl implements WkApService {
	
	@Autowired
	WorkMapper workmapper;
	
	@Override
	public List<WkApVO> workSelect() {
		return workmapper.workSelect();
	}

	@Override
	public int workInsert(WkApVO wkapVO) {
		return workmapper.workInsert(wkapVO);
	}

	@Override
	public int workUpdate(WkApVO wkapVO) {
		return workmapper.workUpdate(wkapVO);
	}

	@Override
	public int workDelete(WkApVO wkapVO) {
		return workmapper.workDelete(wkapVO);
	}

	@Override
	public Integer totalWork(String waAper) {
		return workmapper.totalWork(waAper);
	}

	@Override
	public List<WkApVO> workOneSelect() {
		return workmapper.workOneSelect();
	}

	@Override
	public List<WkApVO> getEmpSelect(String waAper) {
		return workmapper.getEmpSelect(waAper);
	}

	@Override
	public List<WkApVO> countEMP() {
		return workmapper.countEMP();
	}

	@Override
	public WkApVO OneSelect(WkApVO wkapVO) {
		return workmapper.OneSelect(wkapVO);
	}
	
    @Override
    public void generateExcelFile(List<WkApVO> wkapList, String filePath, HttpServletResponse response) {
    	try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("사원 근무스케줄");
            
            // 날짜 포맷 스타일을 설정
            CellStyle cellStyle = workbook.createCellStyle();
            DataFormat dataFormat = workbook.createDataFormat();
            cellStyle.setDataFormat(dataFormat.getFormat("yyyy-MM-dd")); // 날짜 포맷 지정
            
            // 열 헤더 생성
            Row headerRow = sheet.createRow(0);
            String[] headers = {"근무자", "신청자", "승인자", "근무일", "근무시작시간", "근무종료시간", "종일여부", "연장근무시간", "야간근무시간", "휴일근무시간", "근무유형", "결재상태", "기본휴게시간", "결재일자", "반려사유", "근무신청삭제여부코드", "근무유형별 색상"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // 데이터 채우기
            int rowNum = 1;
            for (WkApVO wkapVO : wkapList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(wkapVO.getEmpNm());
                row.createCell(1).setCellValue(wkapVO.getWaAper());
                row.createCell(2).setCellValue(wkapVO.getWaRver());
                
                // 날짜 셀에 스타일 적용
                Cell dateCell = row.createCell(3);
                dateCell.setCellValue(wkapVO.getWaDate());
                dateCell.setCellStyle(cellStyle); // 날짜 스타일 적용
                
                // 날짜 셀에 스타일 적용
                Cell startTimeCell = row.createCell(4);
                startTimeCell.setCellValue(wkapVO.getWaStime());
                startTimeCell.setCellStyle(cellStyle); // 날짜 스타일 적용
                
                // 날짜 셀에 스타일 적용
                Cell endTimeCell = row.createCell(5);
                endTimeCell.setCellValue(wkapVO.getWaEtime());
                endTimeCell.setCellStyle(cellStyle); // 날짜 스타일 적용
                
                row.createCell(6).setCellValue(wkapVO.isWaAllday() ? "종일" : "반일");
                row.createCell(7).setCellValue(wkapVO.getWaExtime());
                row.createCell(8).setCellValue(wkapVO.getWaNightime());
                row.createCell(9).setCellValue(wkapVO.getHdtime());
                row.createCell(10).setCellValue(wkapVO.getWaType());
                row.createCell(11).setCellValue(wkapVO.getEwApst());
                row.createCell(12).setCellValue(wkapVO.getWaTltime());
                
                // 날짜 셀에 스타일 적용
                Cell ewAdateCell = row.createCell(13);
                ewAdateCell.setCellValue(wkapVO.getEwAdate());
                ewAdateCell.setCellStyle(cellStyle); // 날짜 스타일 적용
                
                row.createCell(14).setCellValue(wkapVO.getEwRejrsn());
                row.createCell(15).setCellValue(wkapVO.getWaDel());
                row.createCell(16).setCellValue(wkapVO.getWkColor());
            }

            // 열 너비 지정 
            for (int columnIndex = 0; columnIndex < 17; columnIndex++) {
                sheet.setColumnWidth(columnIndex, 18 * 256); // 15 characters
            }
            
            // 파일 저장
            try (FileOutputStream outputStream = new FileOutputStream(filePath)) {
                workbook.write(outputStream);
                log.info("제대로들어와라 제발" + filePath);
            }

     
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
    }
    
    // 문서 INSERT 
	@Override
	public int docInsert(DocWriVO vo) {
		return workmapper.docInsert(vo);
	}
	
	// 결재선 INSERT
	@Override
	public int apboxInsert(ApboxVO vo) {
		return workmapper.apboxInsert(vo);
	}

	// DOC_WRI 테이블에서 DFT_NO 셀렉트
	@Override
	public int selectdftNo() {
		return workmapper.selectdftNo();
	}
	
	// 근무 결재 승인자 사번가져오기
	@Override
	public String workAuthSelect() {
		return workmapper.workAuthSelect();
	}

	@Override
	public List<WorkVO> workTypeList() {
		return workmapper.workTypeList();
	} 

}
