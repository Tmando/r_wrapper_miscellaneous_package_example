# install.packages("readr")


encode_decode_middleware = RestRserve::EncodeDecodeMiddleware$new()

encode_decode_middleware$ContentHandlers$set_encode(
  "application/octet-stream", 
  function(x) {
    con = rawConnection(raw(0), "wb")
    on.exit(close(con))
    writeBin(x, con)
    rawConnectionValue(con)
  }
)

app = RestRserve::Application$new(middleware = list(encode_decode_middleware))



logging_middleware = RestRserve::Middleware$new(
  process_request = function(.req, .res) {
    msg = list(
      middleware = "logging_middleware",
      request_id = .req$id,
      request = list(headers = .req$headers, method = .req$method, path = .req$path), 
      timestamp = Sys.time()
    )
    msg = RestRserve::to_json(msg)
    cat(msg, sep = '\n')
  },
  process_response = function(.req, .res) {
    msg = list(
      middleware = "logging_middleware",
      # we would like to have a request_id for each response in order to correlate
      # request and response
      request_id = .req$id,
      response = list(headers = .res$headers, status_code = .res$status_code, body = .res$body),
      timestamp = Sys.time()
    )
    msg = RestRserve::to_json(msg)
    cat(msg, sep = '\n')
  },
  id = "logging"
)

app$append_middleware(logging_middleware)


app$add_get(
  path = "/hello_world", 
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::hello_world())
    )
  }
)

app$add_post(
  path = "/add_num", 
  FUN = function(.req, .res) {
    if (!is.numeric(.req$body$a) || !is.numeric(.req$body$b)) {
        stop(paste("a and b must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::add_num(
        .req$body$a,
        .req$body$b
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/sub_num", 
  FUN = function(.req, .res) {
    if (!is.numeric(.req$body$a) || !is.numeric(.req$body$b)) {
        stop(paste("a and b must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::sub_num(
        .req$body$a,
        .req$body$b
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/mul_num", 
  FUN = function(.req, .res) {
    if (!is.numeric(.req$body$a) || !is.numeric(.req$body$b)) {
        stop(paste("a and b must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::mul_num(
        .req$body$a,
        .req$body$b
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/mod_num", 
  FUN = function(.req, .res) {
    if (!is.numeric(.req$body$a) || !is.numeric(.req$body$b)) {
        stop(paste("a and b must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::mod_num(
        .req$body$a,
        .req$body$b
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/levenshtein", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$alpha_str) || 
    !is.character(.req$body$beta_str)) {
        stop(paste("alpha_str and beta_str must be string"))
    }
    result <- RWrapperMiscellaneousPkg::levenshtein(
        .req$body$alpha_str,
        .req$body$beta_str
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/hamming_smid", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$alpha_str) || !is.character(.req$body$beta_str)) {
        stop(paste("alpha_str and beta_str must be string"))
    }
    result <- RWrapperMiscellaneousPkg::hamming_smid(
        .req$body$alpha_str,
        .req$body$beta_str
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/bom_matching", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$alpha_str) || !is.character(.req$body$beta_str)) {
        stop(paste("alpha_str and beta_str must be string"))
    }
    result <- RWrapperMiscellaneousPkg::bom_matching(
        .req$body$alpha_str,
        .req$body$beta_str
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/bndm_matching", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$alpha_str) || !is.character(.req$body$beta_str)) {
        stop(paste("alpha_str and beta_str must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::bndm_matching(
        .req$body$alpha_str,
        .req$body$beta_str
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/horspool_matching", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$alpha_str) || !is.character(.req$body$beta_str)) {
        stop(paste("alpha_str and beta_str must be numeric"))
    }
    result <- RWrapperMiscellaneousPkg::horspool_matching(
        .req$body$alpha_str,
        .req$body$beta_str
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/kmp_matching", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$pattern) || !is.character(.req$body$text)) {
        stop(paste("pattern and text must be string"))
    }
    result <- RWrapperMiscellaneousPkg::kmp_matching(
        .req$body$pattern,
        .req$body$text
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/hamming", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$pattern) || !is.character(.req$body$text)) {
        stop(paste("pattern and text must be string"))
    }
    result <- RWrapperMiscellaneousPkg::hamming(
        .req$body$pattern,
        .req$body$text
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/get_sha224", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)) {
        stop(paste("input must be a string"))
    }
    result <- RWrapperMiscellaneousPkg::get_sha224(
        .req$body$input
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/get_sha384", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)) {
        stop(paste("input must be a string"))
    }
    result <- RWrapperMiscellaneousPkg::get_sha384(
        .req$body$input
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/get_sha512", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)) {
        stop(paste("input must be a string"))
    }
    result <- RWrapperMiscellaneousPkg::get_sha512(
        .req$body$input
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/get_sha1", 
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)) {
        stop(paste("input must be a string"))
    }
    result <- RWrapperMiscellaneousPkg::get_sha1(
        .req$body$input
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/get_random_number_range", 
  FUN = function(.req, .res) {
    if (
        !is.numeric(.req$body$min_num) &&
        !is.numeric(.req$body$max_num) 
    ) {
        stop(paste("min_num,max_num must be number"))
    }
    result <- RWrapperMiscellaneousPkg::get_random_number_range(
        .req$body$min_num,
        .req$body$max_num
    )
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )
  }
)

app$add_post(
  path = "/resize_image", 
  FUN = function(.req, .res) {
    # for debug
    if(length(.req$files) == 1){
        image <- .req$get_file("input_image")
        input_file_name <- .req$files$input_image$filename
        out_put_file_name <- paste0(Sys.time(), .req$files$input_image$filename)
    }else{
      stop("input_file not set")
    }

    con = file(input_file_name, "wb")
    writeBin(as.raw(image), con)
    close(con)

    res <- RWrapperMiscellaneousPkg::resize_image(
                                            .req$files$input_image$filename,
                                            ifelse(!is.null(.req$parameters_body$nwidth),as.numeric(.req$parameters_body$nwidth),200),
                                            ifelse(!is.null(.req$parameters_body$nwidth),as.numeric(.req$parameters_body$nheight),200),
                                            ifelse(!is.null(.req$parameters_body$filter),as.character(.req$parameters_body$filter),'Nearst'),
                                            out_put_file_name,
                                            TRUE)
  file.remove(input_file_name)
  raw_dat <- readr::read_file_raw(out_put_file_name)
  if(res == TRUE){
    file.remove(out_put_file_name)
  }
  .res$set_content_type("application/octet-stream")
  .res$set_body(
        raw_dat
  )    
  }
)

app$add_get("/get_city", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_city())
    )
  }
})

app$add_get("/get_country", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_country())
    )
  }
})

app$add_get("/get_latitude", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_latitude())
    )
  }
})

app$add_get("/get_longitude", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_longitude())
    )
  }
})

app$add_get("/get_state", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_state())
    )
  }
})

app$add_get("/get_street", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_street())
    )
  }
})

app$add_get("/get_street_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_street_name())
    )
  }
})

app$add_get("/get_street_number", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_street_number())
    )
  }
})

app$add_get("/get_street_prefix", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_street_prefix())
    )
  }
})

app$add_get("/get_street_suffix", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_street_suffix())
    )
  }
})

app$add_get("/get_zip", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_zip())
    )
  }
})

app$add_get("/get_anmimal", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_anmimal())
    )
  }
})

app$add_get("/get_cat", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_cat())
    )
  }
})

app$add_get("/get_dog", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_dog())
    )
  }
})

app$add_get("/get_farm", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_farm())
    )
  }
})

app$add_get("/get_pet_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_pet_name())
    )
  }
})

app$add_get("/get_alcohol", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_alcohol())
    )
  }
})


app$add_get("/get_blg", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_blg())
    )
  }
})

app$add_get("/get_hop", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_hop())
    )
  }
})

app$add_get("/get_ibu", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_ibu())
    )
  }
})

app$add_get("/get_malt", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_malt())
    )
  }
})

app$add_get("/get_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_name())
    )
  }
})

app$add_get("/get_style", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_style())
    )
  }
})

app$add_get("/get_yeast", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_yeast())
    )
  }
})

app$add_get("/get_bool", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_bool())
    )
  }
})

app$add_get("/get_full_color", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_full_color())
    )
  }
})

app$add_get("/get_hex_color", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_hex_color())
    )
  }
})

app$add_get("/get_safe_color", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_safe_color())
    )
  }
})

app$add_get("/get_company", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_company())
    )
  }
})

app$add_get("/get_buzzword", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_buzzword())
    )
  }
})

app$add_get("/get_bs", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_bs())
    )
  }
})

app$add_get("/get_company_suffix", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_company_suffix())
    )
  }
})

app$add_get("/get_email", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_email())
    )
  }
})

app$add_get("/get_phone", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_phone())
    )
  }
})

app$add_get("/get_phone_formatted", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_phone_formatted())
    )
  }
})

app$add_get("/get_currency_long", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_currency_long())
    )
  }
})

app$add_get("/get_currency_short", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_currency_short())
    )
  }
})

app$add_get("/get_day", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_day())
    )
  }
})

app$add_get("/get_hour", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_hour())
    )
  }
})

app$add_get("/get_minute", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_minute())
    )
  }
})

app$add_get("/get_secound", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_secound())
    )
  }
})

app$add_get("/get_timezone", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_timezone())
    )
  }
})

app$add_get("/get_week_day", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_week_day())
    )
  }
})

app$add_get("/get_year", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_year())
    )
  }
})

app$add_get("/get_extension", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_extension())
    )
  }
})

app$add_get("/get_mime_type", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_mime_type())
    )
  }
})

app$add_get("/get_abbreviation", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_abbreviation())
    )
  }
})

app$add_get("/get_adjective", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_adjective())
    )
  }
})

app$add_get("/get_ingverb", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_ingverb())
    )
  }
})

app$add_get("/get_noun", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_noun())
    )
  }
})

app$add_get("/get_pharse", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_pharse())
    )
  }
})

app$add_get("/get_verb", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_verb())
    )
  }
})

app$add_get("/get_hippster_word", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_hippster_word())
    )
  }
})

app$add_get("/get_domain_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_domain_name())
    )
  }
})

app$add_get("/get_domain_suffix", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_domain_suffix())
    )
  }
})

app$add_get("/get_http_method", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_http_method())
    )
  }
})

app$add_get("/get_ipv4_address", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_ipv4_address())
    )
  }
})

app$add_get("/get_ipv6_address", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_ipv6_address())
    )
  }
})

app$add_get("/get_mac_address", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_mac_address())
    )
  }
})

app$add_get("/get_username", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_username())
    )
  }
})

app$add_get("/get_job_descriptor", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_job_descriptor())
    )
  }
})

app$add_get("/get_job_level", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_job_level())
    )
  }
})

app$add_get("/get_job_title", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_job_title())
    )
  }
})

app$add_get("/get_language_abbreviation", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_language_abbreviation())
    )
  }
})

app$add_get("/get_language_programming", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_language_programming())
    )
  }
})

app$add_get("/get_language_random", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_language_random())
    )
  }
})

app$add_get("/get_log_level_appache", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_log_level_appache())
    )
  }
})

app$add_get("/get_log_level_general", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_log_level_general())
    )
  }
})

app$add_get("/get_log_level_sys_log", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_log_level_sys_log())
    )
  }
})

app$add_get("/get_first_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_first_name())
    )
  }
})

app$add_get("/get_last_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_last_name())
    )
  }
})

app$add_get("/get_prefix_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_prefix_name())
    )
  }
})

app$add_get("/get_suffix_name", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_suffix_name())
    )
  }
})

app$add_get("/get_credit_card_type", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_credit_card_type())
    )
  }
})

app$add_get("/get_credit_card_number", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_credit_card_number())
    )
  }
})

app$add_get("/get_credit_card_luhn_number", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_credit_card_luhn_number())
    )
  }
})

app$add_get("/get_credit_card_exp", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_credit_card_exp())
    )
  }
})

app$add_get("/get_credit_card_ccv", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_credit_card_ccv())
    )
  }
})

app$add_get("/get_status_codes_general", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_status_codes_general())
    )
  }
})

app$add_get("/get_status_codes_simple", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_status_codes_simple())
    )
  }
})

app$add_get("/get_uuid_v1", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_uuid_v1())
    )
  }
})

app$add_get("/get_uuid_v4", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_uuid_v4())
    )
  }
})

app$add_get("/get_user_agent_chrome", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_chrome())
    )
  }
})

app$add_get("/get_user_agent_firefox", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_firefox())
    )
  }
})

app$add_get("/get_user_agent_linux_platform_token", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_linux_platform_token())
    )
  }
})

app$add_get("/get_user_agent_mac_platform_token", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_mac_platform_token())
    )
  }
})

app$add_get("/get_user_agent_opera", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_opera())
    )
  }
})

app$add_get("/get_user_agent_random_platform", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_random_platform())
    )
  }
})

app$add_get("/get_user_agent_safari", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_safari())
    )
  }
})

app$add_get("/get_user_agent_windows_platform_token", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_user_agent_windows_platform_token())
    )
  }
})

app$add_get("/get_car_maker", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_car_maker())
    )
  }
})

app$add_get("/get_car_model", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_car_model())
    )
  }
})

app$add_get("/get_fuel", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_fuel())
    )
  }
})

app$add_get("/get_transmission_gear", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_transmission_gear())
    )
  }
})

app$add_get("/get_vehicle_type", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_vehicle_type())
    )
  }
})

app$add_get("/get_question", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_question())
    )
  }
})

app$add_get("/get_quote", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_quote())
    )
  }
})

app$add_get("/get_word", {
  FUN = function(.req, .res) {
    .res$set_content_type("application/json")
    .res$set_body(
        list(result = RWrapperMiscellaneousPkg::get_word())
    )
  }
})

app$add_post("/read_sheet_by_name", {
  FUN = function(.req, .res) {
    if(
      !("input_excel" %in% names(.req$parameters_body$input_excel)) && 
      !("sheet_name" %in% names(.req$parameters_body))
    ){
      stop("Parameter input_excel and sheet_name must be set")
    }

    input_excel <- .req$get_file("input_excel")
    
    con <- file(.req$parameters_body$input_excel, "wb")
    writeBin(as.raw(input_excel), con)
    close(con)

    sheet_name <- .req$parameters_body$sheet_name

    result <- RWrapperMiscellaneousPkg::read_sheet_by_name(.req$parameters_body$input_excel, sheet_name)
    
    file.remove(.req$parameters_body$input_excel)

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result)
    )

  }
})

app$add_post("/match_regex_string", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$regex_input) || !is.character(.req$body$seach_string)) {
        stop(paste("a and b must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- RWrapperMiscellaneousPkg::match_regex_string(.req$body$regex_input,.req$body$seach_string))
    )
  }
})

app$add_post("/replace_regex_string", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$regex_input) || !is.character(.req$body$seach_string)) {
        stop(paste("a and b must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- RWrapperMiscellaneousPkg::match_regex_string(.req$body$regex_input,.req$body$seach_string))
    )
  }
})

app$add_post("/cs_shake_v256", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$name) || 
        !is.character(.req$body$custom_string) || 
        !is.character(.req$body$input)) {
        stop(paste("name, custom_string, input must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::cs_shake_v256(
          as.raw(.req$body$name),
          as.raw(.req$body$custom_string),
          as.raw(.req$body$input)
        )
        )
    )
  }
})

app$add_post("/kangaroo_twelve_xof", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$custom_string) || 
        !is.character(.req$body$input)) {
        stop(paste("name, custom_string, input must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::kangaroo_twelve_xof(
          as.raw(.req$body$custom_string),
          as.raw(.req$body$input)
        )
        )
    )
  }
})

app$add_post("/kangaroo_twelve", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$custom_string) || 
        !is.character(.req$body$input)) {
        stop(paste("name, custom_string, input must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::kangaroo_twelve(
          as.raw(.req$body$custom_string),
          as.raw(.req$body$input)
        )
        )
    )
  }
})

app$add_post("/cs_shake_v128", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$name) || 
        !is.character(.req$body$custom_string) || 
        !is.character(.req$body$input)
        ) {
        stop(paste("name, custom_string, input must be a string"))
    }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::cs_shake_v128(
          as.raw(.req$body$name),
          as.raw(.req$body$custom_string),
          as.raw(.req$body$input)
        )
        )
    )
  }
})

app$add_post("/keccak_v224", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)
        ) {
          stop(paste("input must be a string"))
        }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::keccak_v224(
          as.raw(.req$body$input)
        )
        )
    )
  }
})

app$add_post("/keccak_v256", {
  FUN = function(.req, .res) {
    if (!is.character(.req$body$input)
        ) {
          stop(paste("input must be a string"))
        }

    .res$set_content_type("application/json")
    .res$set_body(
        list(result = result <- 
        RWrapperMiscellaneousPkg::keccak_v256(
          as.raw(.req$body$input)
        )
        )
    )
  }
})

test_requests <- function(app){

  rq_hello_world <- RestRserve::Request$new(
    path = "/hello_world",
    method = c("GET")
  )
  response <- app$process_request(rq_hello_world)
  str(response$body)

  rq_add_num <- RestRserve::Request$new(
    path = "/add_num",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      a = 10,
      b = 30
    ))
  )
  response <- app$process_request(rq_add_num)
  str(response$body)

  rq_sub_num <- RestRserve::Request$new(
    path = "/sub_num",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      a = 10,
      b = 50
    ))
  )
  response <- app$process_request(rq_sub_num)
  str(response$body)

  rq_mul_num <- RestRserve::Request$new(
    path = "/mul_num",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      a = 10,
      b = 50
    ))
  )
  response <- app$process_request(rq_mul_num)
  str(response$body)

  rq_mod_num <- RestRserve::Request$new(
    path = "/mod_num",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      a = 100,
      b = 50
    ))
  )
  response <- app$process_request(rq_mod_num)
  str(response$body)

  rq_levenshtein <- RestRserve::Request$new(
    path = "/levenshtein",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      alpha_str = "Hallo Welt",
      beta_str = "Hallo Telt"
    ))
  )
  response <- app$process_request(rq_levenshtein)
  str(response$body)


  rq_hamming_smid <- RestRserve::Request$new(
    path = "/hamming_smid",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      alpha_str = "Hallo Welt",
      beta_str = "Hallo Telt"
    ))
  )
  response <- app$process_request(rq_hamming_smid)
  str(response$body)

  rq_bom_matching <- RestRserve::Request$new(
    path = "/bom_matching",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      alpha_str = "Hallo Welt",
      beta_str = "Hallo Telt"
    ))
  )
  response <- app$process_request(rq_bom_matching)
  str(response$body)

  rq_horspool_matching <- RestRserve::Request$new(
    path = "/horspool_matching",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      alpha_str = "Hallo Welt",
      beta_str = "Hallo Telt"
    ))
  )
  response <- app$process_request(rq_horspool_matching)
  str(response$body)

  rq_hamming <- RestRserve::Request$new(
    path = "/hamming",
    method = c("POST"),
    content_type = "application/json",
    body = jsonlite::toJSON(list(
      pattern = "Hallo Welt",
      text = "Hallo Telt"
    ))
  )
  response <- app$process_request(rq_hamming)
  str(response$body)
}

test_requests(app)


backend = RestRserve::BackendRserve$new()
backend$start(app, http_port = 8097)