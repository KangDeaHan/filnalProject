package kr.or.ddit.salary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.salary.vo.PayDedVO;

@Mapper
public interface PayDedMapper {
	
	// 지급항목 법정필수항목 전체 리스트 출력
	//<select id="selectLawPayList" resultType="PayDedVO">
	public List<PayDedVO> selectLawPayList();

	// 지급항목 추가한 항목 전체 리스트 출력
	//<select id="selectAddedPayList" resultType="PayDedVO">
	public List<PayDedVO> selectAddedPayList();
	
	// 공제항목 법정필수항목 전체 리스트 출력
	//<select id="selectLawDedList" resultType="PayDedVO">
	public List<PayDedVO> selectLawDedList();
	
	// 공제항목 추가한 항목 전체 리스트 출력
	//<select id="selectAddedDedList" resultType="PayDedVO">
	public List<PayDedVO> selectAddedDedList();
	
	//지급/공제항목 항목당 한건 검색
	//<select id="selectPD" parameterType="int" resultType="PayDedVO">
	public PayDedVO selectPD(int pdNo);
	
	//급여템플릿구성테이블에서 지급/공제항목 있는지 확인 (count)
	//<select id="selectPTMCount" parameterType="PayDedVO" resultType="int">
	public int selectPTMCount(PayDedVO payDedVO);
	
	//급여템플릿구성테이블에서 지급/공제항목 있는지 확인 
	//<select id="selectPTMList" parameterType="int" resultType="PayDedVO">
	public List<PayDedVO> selectPTMList(int ptNo);
	
	// 지급/공제항목 추가
	//<insert id="insertPD" parameterType="PayDedVO">
	public int insertPD(PayDedVO payDedVO);
	
	//지급/공제항목 변경
	//<update id="updatePD" parameterType="PayDedVO">
	public int updatePD(PayDedVO payDedVO);
	
	//지급/공제항목 삭제
	//<delete id="deletePD" parameterType="PayDedVO">
	public int deletePD(PayDedVO payDedVO);
	
	//템플릿구성 추가
 	//<insert id="insertPTM" parameterType="PayDedVO" >
	public int insertPTM(PayDedVO payDedVO);
	
	//템플릿구성 삭제
 	//<delete id="deletePTM" parameterType="PayDedVO"> 
	public int deletePTM(PayDedVO payDedVO);
	
}
