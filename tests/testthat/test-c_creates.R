test_that("c_patient_type_cohort creates the required variable", {

  df <- dplyr::tbl(test_con, "c_patient_type_cohort") |>
    c_patient_type_cohort() |>
    dplyr::collect()

  expect_true("patient_type_cohort" %in% names(df))
  expect_equal(dplyr::pull(df["patient_type_cohort"]),
               c("Inpatient/Day case",
                 "Inpatient/Day case",
                 "New Outpatient",
                 "Return outpatient"))
})

test_that("c_grouped_specialty_desc creates the required variable", {

  df <- dplyr::tbl(test_con, "c_grouped_specialty_desc") |>
    c_grouped_specialty_desc() |>
    dplyr::collect()

  expect_true("grouped_specialty_desc" %in% names(df))
  expect_equal(dplyr::pull(df["grouped_specialty_desc"]),
               c("GENERAL MEDICINE",
                 "ENDOCRINOLOGY & DIABETES",
                 "GENERAL SURGERY",
                 "ANAESTHETICS",
                 "CARDIOTHORACIC SURGERY",
                 "EAR, NOSE & THROAT",
                 "GP",
                 "OBSTETRICS",
                 "CHILD & ADOLESCENT PSYCHIATRY",
                 "SURGICAL PODIATRY",
                 "MIDWIFERY",
                 "CARDIOLOGY",
                 "PAEDIATRICS",
                 "OBSTETRICS & GYNAECOLOGY",
                 "GENERAL PSYCHIATRY (MENTAL ILLNESS)",
                 "AUDIOLOGICAL SCIENCE",
                 "DIAGNOSTIC RADIOGRAPHY",
                 "GENERAL NURSING",
                 "MENTAL HEALTH NURSING",
                 "CLINICAL RADIOLOGY",
                 "PLASTIC SURGERY"))
})

