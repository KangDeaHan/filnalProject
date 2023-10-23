package kr.or.ddit.excelupload;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;

public class ExcelCellRef {
    /**
     * Cell에 해당하는 Column Name을 가젼온다(A,B,C..)
     * 만약 Cell이 Null이라면 int cellIndex의 값으로
     * Column Name을 가져온다.
     * @param cell
     * @param cellIndex
     * @return
     */
    public static String getName(Cell cell, int cellIndex) {
        int cellNum = 0;
        if(cell != null) {
            cellNum = cell.getColumnIndex();
        }
        else {
            cellNum = cellIndex;
        }
        
        return CellReference.convertNumToColString(cellNum);
    }
    public static String getValue(Cell cell) {
        String value = "";

        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case FORMULA:
                value = cell.getCellFormula();
                break;

            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    // 날짜 형식인 경우 날짜 값을 문자열로 변환
                    value = cell.getDateCellValue().toString();
                } else {
                    // 일반 숫자인 경우 숫자 값을 문자열로 변환
                    value = String.valueOf((int) cell.getNumericCellValue());
                }
                break;

            case STRING:
                value = cell.getStringCellValue();
                break;

            case BOOLEAN:
                value = String.valueOf(cell.getBooleanCellValue());
                break;

            case BLANK:
                value = "";
                break;

            case ERROR:
                value = String.valueOf(cell.getErrorCellValue());
                break;

            default:
                value = cell.getStringCellValue();
        }

        return value;
    }
 
}