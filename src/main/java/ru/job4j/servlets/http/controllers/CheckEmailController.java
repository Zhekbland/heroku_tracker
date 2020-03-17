package ru.job4j.servlets.http.controllers;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import ru.job4j.servlets.http.logic.ValidateService;
import ru.job4j.servlets.http.persistent.User;
import ru.job4j.servlets.http.persistent.Validate;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

public class CheckEmailController extends HttpServlet {

    private final Validate validateService = ValidateService.getInstance();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json");
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> usersInfo = mapper.readValue(req.getReader().readLine(),
                new TypeReference<Map<String, String>>() {
                });
        User actualUser = this.validateService.findByEmail(usersInfo.get("userEmail"));
        boolean loginExists = (actualUser != null) && (actualUser.getId() != Integer.parseInt(usersInfo.get("userId")));
        try (PrintWriter writer = resp.getWriter()) {
            writer.println(mapper.writeValueAsString(loginExists));
        }
    }
}
