CREATE DATABASE crm_application;

\c crm_application;

CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    company VARCHAR(160) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    phone VARCHAR(40),
    segment VARCHAR(60) NOT NULL DEFAULT 'Retail',
    status VARCHAR(40) NOT NULL DEFAULT 'Active',
    notes TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE leads (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(160) NOT NULL,
    company VARCHAR(160) NOT NULL,
    source VARCHAR(80) NOT NULL DEFAULT 'Website',
    value BIGINT NOT NULL DEFAULT 0,
    status VARCHAR(40) NOT NULL DEFAULT 'New',
    contact_email VARCHAR(160),
    contact_phone VARCHAR(40),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE deals (
    id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NULL REFERENCES customers(id) ON DELETE SET NULL,
    title VARCHAR(160) NOT NULL,
    customer VARCHAR(160) NOT NULL,
    stage VARCHAR(60) NOT NULL DEFAULT 'Proposal',
    amount BIGINT NOT NULL DEFAULT 0,
    probability SMALLINT NOT NULL DEFAULT 0 CHECK (probability >= 0 AND probability <= 100),
    expected_close_date DATE NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE activities (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(160) NOT NULL,
    contact VARCHAR(120) NOT NULL,
    type VARCHAR(60) NOT NULL DEFAULT 'Call',
    due_at TIMESTAMP NULL,
    is_done BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

CREATE INDEX idx_leads_status ON leads(status);
CREATE INDEX idx_deals_stage ON deals(stage);
CREATE INDEX idx_activities_due_at ON activities(due_at);

INSERT INTO customers (name, company, email, phone, segment, status, created_at, updated_at) VALUES
('Aditya Pratama', 'Nusantara Retail', 'aditya@nusantararetail.id', '+62 812 3300 1984', 'Enterprise', 'Active', NOW(), NOW()),
('Maya Cahyani', 'Sagara Logistic', 'maya@sagaralogistic.id', '+62 811 9044 7788', 'SMB', 'Active', NOW(), NOW()),
('Rafi Wiratama', 'Bright Edu', 'rafi@brightedu.id', '+62 857 2199 7701', 'Startup', 'Prospect', NOW(), NOW());

INSERT INTO leads (name, company, source, value, status, created_at, updated_at) VALUES
('Procurement System', 'Mandala Group', 'Website', 72000000, 'Qualified', NOW(), NOW()),
('Sales Automation', 'Bumi Medika', 'Referral', 46000000, 'New', NOW(), NOW()),
('CRM Migration', 'Karya Finance', 'Campaign', 93500000, 'Contacted', NOW(), NOW());

INSERT INTO deals (customer_id, title, customer, stage, amount, probability, expected_close_date, created_at, updated_at) VALUES
(1, 'Enterprise CRM Rollout', 'Nusantara Retail', 'Negotiation', 115000000, 74, CURRENT_DATE + INTERVAL '21 days', NOW(), NOW()),
(2, 'Helpdesk Integration', 'Sagara Logistic', 'Proposal', 38000000, 51, CURRENT_DATE + INTERVAL '35 days', NOW(), NOW()),
(3, 'Analytics Add-on', 'Bright Edu', 'Won', 29500000, 100, CURRENT_DATE - INTERVAL '8 days', NOW(), NOW());

INSERT INTO activities (title, contact, type, due_at, is_done, created_at, updated_at) VALUES
('Follow up proposal', 'Aditya Pratama', 'Call', CURRENT_DATE + TIME '10:30', false, NOW(), NOW()),
('Demo pipeline report', 'Maya Cahyani', 'Meeting', CURRENT_DATE + TIME '14:00', false, NOW(), NOW()),
('Send renewal quotation', 'Rafi Wiratama', 'Email', NOW() + INTERVAL '1 day', true, NOW(), NOW());
