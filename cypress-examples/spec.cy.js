describe("Resume tests", function () {
  it("visits resume page", function () {
    cy.visit(
      "http://resume-website-hosting.s3-website.me-central-1.amazonaws.com/Resume/resume.html"
    );

    cy.wait(4000);
    cy.get(".counter")
      .invoke("text")
      .then((text1) => {
        cy.reload();
        cy.wait(4000);
        cy.get(".counter")
          .invoke("text")
          .should((text2) => {
            expect(parseInt(text2)).to.eq(parseInt(text1) + 1);
          });
      });
  });
  it("checks the database", function () {
    //checks the database entry through either the js apis or the cli or lambda function
  });
});
