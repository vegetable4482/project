package com.kh.myapp.bbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.kh.myapp.bbs.dao.FrbbsDAO;

import com.kh.myapp.bbs.dto.FrbbsDTO;

@Service
public class FrbbsSVCImpl implements FrbbsSVC {

	private static Logger logger = LoggerFactory.getLogger(FrbbsSVCImpl.class);

	@Inject
	FrbbsDAO frbbsDAO;

	@Override
	public int write(FrbbsDTO frbbsDTO) {

		return frbbsDAO.write(frbbsDTO);
	}

	@Override
	public List<FrbbsDTO> list(String freerbnum) {

		return frbbsDAO.list(freerbnum);
	}

	@Override
	public List<FrbbsDTO> list(String freerbnum, int startRec, int endRec) {

		return frbbsDAO.list(freerbnum, startRec, endRec);
	}

	@Override
	public int modify(FrbbsDTO frbbsDTO) {

		return frbbsDAO.modify(frbbsDTO);
	}

	@Override
	public int delete(String freernum) {

		return frbbsDAO.delete(freernum);
	}

	@Override
	public int goodOrBad(String freernum, String freegoodOrBad) {

		return frbbsDAO.goodOrBad(freernum, freegoodOrBad);
	}

	@Override
	public int reply(FrbbsDTO frbbsDTO) {

		return frbbsDAO.reply(frbbsDTO);
	}

	@Override
	public int replyTotalRec(String freerbnum) {

		return frbbsDAO.replyTotalRec(freerbnum);
	}

}
