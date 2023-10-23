package kr.or.ddit.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.salary.vo.PayTplVO;

@Mapper
public interface PayTplMapper {
	
	//템플릿 목록 (전체 검색)
	//<select id="selectTplList" resultType="PayTplVO">		
	public List<PayTplVO> selectTplList();
	
	//한 건 검색
	//<select id="selectTpl" parameterType="int" resultType="PayTplVO">
	public PayTplVO selectTpl(int ptNo);
	
	//템플릿 추가
	//<insert id="insertTpl" parameterType="PayTplVO">
	public int insertTpl(PayTplVO payTplVO);
	
	//템플릿 변경
	//<update id="updateTpl" parameterType="PayTplVO">
	public int updateTpl(PayTplVO payTplVO);
	
	//템플릿 삭제
	//<delete id="deleteTpl" parameterType="PayTplVO">
	public int deleteTpl(PayTplVO payTplVO);
	
	//템플릿 북마크 상태 변경
	//<update id="updateBmkStatus" parameterType="PayTplVO">
	public int updateBmkStatus(PayTplVO payTplVO);
	
	//급여정산 홈 - 북마크여부코드가 'B0101'인 것만 전체 출력하기
	//<select id="selectBmkOn" resultType="PayTplVO">
	public List<PayTplVO> selectBmkOn();
}
